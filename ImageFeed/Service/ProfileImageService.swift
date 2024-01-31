//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Александр Акимов on 15.01.2024.
//

import UIKit

final class ProfileImageService {
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private let token = OAuth2TokenStorage().token
    
    static var profileImage: String?
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    func fetchProfileImageURL(username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        guard Thread.isMainThread else { return }
        if task != nil {
            return
        }
        let profileImageURL = URL(string: "https://api.unsplash.com/users/\(username)")!
        var request = URLRequest(url: profileImageURL)
        request.httpMethod = "GET"
        guard let token = token else{
            return
        }
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profileResponce):
                    let profileImageURL = profileResponce.profileImage.medium
                    ProfileImageService.profileImage = profileImageURL
                    completion(.success(profileImageURL))
                    NotificationCenter.default
                        .post(
                            name: ProfileImageService.didChangeNotification,
                            object: self,
                            userInfo: ["URL": profileImageURL])
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        self.task = task
        task.resume()
    }
}
