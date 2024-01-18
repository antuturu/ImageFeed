//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation

final class OAuth2Service {
    private let urlSession = URLSession.shared
    
    private var task: URLSessionTask?
    private var lastCode: String?
    
    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        let parameters = [
            "client_id": AccessKey,
            "client_secret": SecretKey,
            "redirect_uri": RedirectURI,
            "code": code,
            "grant_type": "authorization_code"]
        
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuth2ResponceModel, Error>) in
            switch result {
            case .success(let tokenResults):
                DispatchQueue.main.async {
                    completion(.success(tokenResults.access_token))
                }
                print(tokenResults.access_token)
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
