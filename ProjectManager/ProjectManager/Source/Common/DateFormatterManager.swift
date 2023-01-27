//
//  DateFormatterManager.swift
//  ProjectManager
//
//  Created by som on 2023/01/16.
//

import Foundation

struct DateFormatterManager {
    static func formatDate(_ date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
    }

    static func isExpiredDate(_ date: Date) -> Bool? {
        guard let expiredDate = Calendar.current.dateComponents([.year, .month, .day], from: date).day else { return nil }
        guard let currentDate = Calendar.current.dateComponents([.year, .month, .day], from: Date()).day else { return nil }
        return expiredDate < currentDate
    }
}
