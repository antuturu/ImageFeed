//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Александр Акимов on 25.01.2024.
//

import Foundation

final class DateFormatters {
    static let shared = DateFormatters()
    
    let iso8601DateFormatter: ISO8601DateFormatter
    let dateFormatter: DateFormatter
    private init() {
        iso8601DateFormatter = ISO8601DateFormatter()
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM yyyy"
    }
}

