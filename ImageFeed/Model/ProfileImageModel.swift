//
//  ProfileImageModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 15.01.2024.
//

import Foundation

struct UserResult: Codable {
    let profile_image: ProfileImage
    
    private enum CodingKeys : String, CodingKey {
        case profile_image
    }
}

struct ProfileImage: Codable {
    let small: String
}
