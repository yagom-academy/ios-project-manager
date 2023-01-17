//
//  DateFormatterManager.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/14.
//

import Foundation

struct DateFormatterManager {
    func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
}
