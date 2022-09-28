//
//  Date+Extensions.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/25.
//

import UIKit

extension Date {
    var formattedDateForKoreanLocale: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }

    var formattedDateForUSALocale: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss a"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: self)
    }
}
