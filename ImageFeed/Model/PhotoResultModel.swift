//
//  PhotoResultModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 24.01.2024.
//

import Foundation

struct PhotoResult: Codable {
    let id: String
    let width: CGFloat
    let height: CGFloat
    let createdAt: String
    let welcomeDescription: String
    let urls: UrlResult
    let isLiked: Bool
    
    private enum CodingKeys : String, CodingKey {
        case id
        case width
        case height
        case createdAt = "created_at"
        case welcomeDescription = "description"
        case urls = "urls"
        case isLiked = "liked_by_user"
    }
}
