//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Александр Акимов on 19.01.2024.
//

import Foundation

final class ImagesListService {
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    private var page: Int = 1
    private let urlSession = URLSession.shared
    private let token = OAuth2TokenStorage().token
    static let shared = ImagesListService()
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    func fetchPhotosNextPage() {
        assert(Thread.isMainThread)
        if task != nil {
            return
        }
        var urlComponents = URLComponents(string: "https://api.unsplash.com/photos")
        urlComponents?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(10)")
        ]
        
        guard let url = urlComponents?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard let token = token else{
            return
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = urlSession.objectTask(for: request) {[weak self] (result: Result<[PhotoResult], Error>)  in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let photoResults):
                    for photo in photoResults {
                        self.photos.append(Photo(result: photo))
                    }
                    self.page += 1
                    NotificationCenter.default.post(
                        name: ImagesListService.didChangeNotification,
                        object: self,
                        userInfo: ["Photos": self.photos])
                case .failure(let error):
                    print("ошибка \(error)")
                }
                self.task = nil
            }
        }
        self.task = task
        task.resume()
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Void, Error>) -> Void) {
        assert(Thread.isMainThread)
        if task != nil {
            return
        }
        var url = URL(string: "https://api.unsplash.com/photos/\(photoId)/like")
        guard let url = url else { return }
        var request = URLRequest(url: url)
        if isLike {
            request.httpMethod = "DELETE"
        } else {
            request.httpMethod = "POST"
        }
        guard let token = token else{
            return
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<LikePhotoResult, Error>) in
            
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.task = nil
                switch result {
                case .success(let photoResult):
                    if let index = self.photos.firstIndex(where: { $0.id == photoId }) {                        let photo = self.photos[index]
                        let newPhoto = Photo(
                            id: photo.id,
                            width: photo.width,
                            height: photo.height,
                            createdAt: photo.createdAt,
                            welcomeDescription: photo.welcomeDescription,
                            thumbImageURL: photo.thumbImageURL,
                            largeImageURL: photo.largeImageURL,
                            isLiked: !photo.isLiked
                        )
                        self.photos[index] = newPhoto
                    }
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            
        }
        self.task = task
        task.resume()
    }
}
