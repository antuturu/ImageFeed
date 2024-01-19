//
//  ProfileModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 19.01.2024.
//

import Foundation

struct Profile: Equatable {
    let username: String
    let name: String
    let loginName: String
    let bio: String
    
    init(profileResult: ProfileResult) {
        self.username = profileResult.username
        self.name = "\(profileResult.firstName) \(profileResult.lastName)"
        self.loginName = "@\(profileResult.username)"
        self.bio = profileResult.bio ?? ""
    }
}
