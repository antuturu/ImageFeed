//
//  Date+Extensions.swift
//  ImageFeed
//
//  Created by Александр Акимов on 25.01.2024.
//

import Foundation

let dateTimeDefaultFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.YY"
    return dateFormatter
}()

extension Date {
    var dateTimeString: String { dateTimeDefaultFormatter.string(from: self) }
}

