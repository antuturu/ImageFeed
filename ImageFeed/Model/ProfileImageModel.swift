//
//  ProfileImageModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 15.01.2024.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage
    
    private enum CodingKeys : String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let small: String
}
