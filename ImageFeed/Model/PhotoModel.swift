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
    
    init(result photo: PhotoResult) {
        id =  photo.id
        width =  CGFloat(photo.width)
        height = CGFloat(photo.height)
        createdAt = dateTimeDefaultFormatter.date(from: photo.createdAt)
        welcomeDescription = photo.welcomeDescription
        thumbImageURL = photo.urls.thumbImageURL
        largeImageURL = photo.urls.largeImageURL
        isLiked = photo.isLiked
    }
}
