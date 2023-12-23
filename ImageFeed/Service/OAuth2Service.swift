//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation

final class OAuth2Service {
    fileprivate let tokenURL = URL(string: "https://unsplash.com/oauth/token")!
    
    private enum NetworkError: Error {
        case codeError
    }
    
    func fetchAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        let parameters = [
            "client_id": AccessKey,
            "client_secret": SecretKey,
            "redirect_uri": RedirectURI,
            "code": code,
            "grant_type": "authorization_code"]
        
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode < 200 || response.statusCode >= 300 {
                completion(.failure(NetworkError.codeError))
                return
            }
            
            do {
                guard let data = data else {
                    return
                }
                let decoder = JSONDecoder()
                let authTokenResponse = try decoder.decode(OAuth2ResponceModel.self, from: data)
                
                completion(.success(authTokenResponse.access_token))
            } catch {
                
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
}
