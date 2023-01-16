//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/16.
//

import Foundation

struct DateFormatterManager {
    func formatDate(_ date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
    }

    func isExpiredDate() -> Bool {
        fatalError()
    }
}
