//
//  DateUtil.swift
//  ProjectManager
//
//  Created by steven on 7/26/21.
//

import Foundation

class DateUtil {
    static let formatter = DateFormatter()
    static func parseDate(_ dateString: String) -> Date {
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.locale = Locale.current
        return formatter.date(from: dateString) ?? Date()
    }

    static func formatDate(_ date: Date) -> String {
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}
