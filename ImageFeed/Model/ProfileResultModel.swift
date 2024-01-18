//
//  ProfileResultModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 11.01.2024.
//

import Foundation

struct ProfileResult: Codable {
    var username: String
    var firstName: String
    var lastName: String
    var bio: String?
    
    
    private enum CodingKeys : String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}



struct Profile: Equatable {
    var username: String
    var name: String
    var loginName: String
    var bio: String
    
    init(profileResult: ProfileResult) {
        self.username = profileResult.username
        self.name = "\(profileResult.firstName) \(profileResult.lastName)"
        self.loginName = "@\(profileResult.username)"
        self.bio = profileResult.bio ?? ""
    }
}
