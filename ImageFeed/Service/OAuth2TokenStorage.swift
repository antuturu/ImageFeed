//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Александр Акимов on 21.12.2023.
//

import Foundation
import SwiftKeychainWrapper
import WebKit

final class OAuth2TokenStorage {
    static let shared = OAuth2TokenStorage()
    
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
    
    func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        KeychainWrapper.standard.removeObject(forKey: "BearerToken")
    }
    
}
