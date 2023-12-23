//
//  OAuthTokenResponseModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation

struct OAuth2ResponceModel: Decodable {
    var access_token: String
    var token_type: String
    var scope: String
    var created_at: Int
    
    private enum CodingKeys : String, CodingKey {
        case access_token = "access_token"
        case token_type = "token_type"
        case scope = "scope"
        case created_at = "created_at"
    }
}
