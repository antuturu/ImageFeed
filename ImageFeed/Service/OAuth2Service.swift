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
        guard Thread.isMainThread else { return }
        if lastCode == code { return }
        task?.cancel()
        lastCode = code
        var request = URLRequest(url: ApiConstants.tokenURL)
        request.httpMethod = "POST"
        let parameters = [
            "client_id": ApiConstants.accessKey,
            "client_secret": ApiConstants.secretKey,
            "redirect_uri": ApiConstants.redirectURI,
            "code": code,
            "grant_type": "authorization_code"]
        
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OAuth2ResponceModel, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let tokenResults):
                    completion(.success(tokenResults.access_token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        self.task = task
        task.resume()
    }
}
