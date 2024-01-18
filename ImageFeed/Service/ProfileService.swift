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
        assert(Thread.isMainThread)
        if task != nil {
            return
        }
        var request = URLRequest(url: profileURL)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("no-cache", forHTTPHeaderField: "Cache-Control")
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            switch result {
            case .success(let profileResults):
                let profileResult = Profile(profileResult: profileResults)
                ProfileService.profile = profileResult
                DispatchQueue.main.async {
                    completion(.success(profileResult))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        self.task = task
        task.resume()
    }
}
