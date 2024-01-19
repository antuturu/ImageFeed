//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation
import SwiftKeychainWrapper

class OAuth2TokenStorage {
    var token: String? {
        get {
            return KeychainWrapper.standard.string(forKey: "BearerToken")
        }
        set {
            let token = newValue
            guard let token = token else { return }
            let isSuccess = KeychainWrapper.standard.set(token, forKey: "BearerToken")
            guard isSuccess else {
                print("Ошибка сохранения токена")
                return
            }
        }
    }
}
