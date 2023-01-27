//
//  Date+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

extension Date {
    
    static let dateFormatter = DateFormatter()
    var isOverdue: Bool {
        return (Int(Date().timeIntervalSinceReferenceDate) / 86400) > (Int(self.timeIntervalSinceReferenceDate) / 86400)
    }
    
    var localeFormattedText: String {
        let dateFormatter = Self.dateFormatter
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: self)
    }
}
