//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Акимов on 12.12.2023.
//

import Foundation

let AccessKey: String = "Jkio8U77xBQJsWuKUV9zmmf0fIJFtx6SWPOslmN5BMs"
let SecretKey: String = "mRq-kMbndsBK35PrBqKMqD9ppazg1AtrFkdxsX2Hd8M"
let RedirectURI: String = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let tokenURL = URL(string: "https://unsplash.com/oauth/token")!
