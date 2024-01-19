//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Александр Акимов on 11.01.2024.
//

import UIKit

final class ProfileService {
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private var lastProfile: Profile?
    static var profile: Profile?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        guard Thread.isMainThread else { return }
        if task != nil {
            return
        }
        var request = URLRequest(url: ApiConstants.profileURL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profileResults):
                    let profileResult = Profile(profileResult: profileResults)
                    ProfileService.profile = profileResult
                    completion(.success(profileResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        self.task = task
        task.resume()
    }
}
