//
//  OAuthTokenResponseModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation

struct OAuth2ResponceModel: Decodable {
    let access_token: String
    let token_type: String
    let scope: String
    let created_at: Int
    
    private enum CodingKeys : String, CodingKey {
        case access_token
        case token_type
        case scope
        case created_at
    }
}
