//
//  Date+.swift
//  ProjectManager
//
//  Created by GUNDY on 2023/01/11.
//

import Foundation

extension Date {

    var isOverdue: Bool {
        return Date() > self
    }
    var localeFormattedText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages[0])
        dateFormatter.dateStyle = .long

        return dateFormatter.string(from: self)
    }
}
