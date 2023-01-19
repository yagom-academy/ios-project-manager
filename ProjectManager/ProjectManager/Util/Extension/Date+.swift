//
//  Date+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

extension Date {

    var isOverdue: Bool {
        return (Int(Date().timeIntervalSinceReferenceDate) / 86400) > (Int(self.timeIntervalSinceReferenceDate) / 86400)
    }
    
    var localeFormattedText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: self)
    }
}
