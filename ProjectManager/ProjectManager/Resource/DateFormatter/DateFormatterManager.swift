//
//  DateFormatterManager.swift
//  ProjectManager
//
//  Created by dhoney96 on 2022/09/22.
//

import Foundation

class DateFormatterManager {
    private let formatter = DateFormatter()
    private let locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
    
    var dateFormatter: DateFormatter {
        self.formatter.locale = self.locale
        self.formatter.dateStyle = .long
        return formatter
    }
    
    static let shared = DateFormatterManager()
    
    func convertToDateString(from date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
}
