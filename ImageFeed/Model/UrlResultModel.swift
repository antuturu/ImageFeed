//
//  UrlResultModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 24.01.2024.
//

import Foundation

struct UrlResult: Codable {
    let thumbImageURL: String
    let largeImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL = "full"
        case thumbImageURL = "thumb"
    }
}
