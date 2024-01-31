//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Акимов on 12.12.2023.
//

import Foundation

enum ApiConstants {
    static let accessKey: String = "Jkio8U77xBQJsWuKUV9zmmf0fIJFtx6SWPOslmN5BMs"
    static let secretKey: String = "mRq-kMbndsBK35PrBqKMqD9ppazg1AtrFkdxsX2Hd8M"
    static let redirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let tokenURL = URL(string: "https://unsplash.com/oauth/token")!
    static let profileURL = URL(string: "https://api.unsplash.com/me")!
    static let photosURL = URL(string: "https://api.unsplash.com/photos")!
}

