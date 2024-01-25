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
    
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    func fetchPhotosNextPage() {
        guard Thread.isMainThread else { return }
        if task != nil {
            return
        }
        var request = URLRequest(url: ApiConstants.photosURL)
        let parameters = [
            "page": page,
            "per_page": 10]
        
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        request.httpMethod = "GET"
        
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
                    assertionFailure("Ошибка получения изображений \(error)")
                }
            }
        }
        
        
    }
}
