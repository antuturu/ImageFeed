//
//  PhotoModel.swift
//  ImageFeed
//
//  Created by Александр Акимов on 19.01.2024.
//

import Foundation

struct Photo {
    let id: String
    let width: CGFloat
    let height: CGFloat
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
}
extension Photo {
    init(result photo: PhotoResult) {
        self.init(id: photo.id,
                  width: CGFloat(photo.width),
                  height: CGFloat(photo.height),
                  createdAt: DateFormatters.shared.iso8601DateFormatter.date(from: photo.createdAt ?? ""),
                  welcomeDescription: photo.welcomeDescription,
                  thumbImageURL: photo.urls.thumbImageURL,
                  largeImageURL: photo.urls.largeImageURL,
                  isLiked: photo.isLiked)
        
    }
}
