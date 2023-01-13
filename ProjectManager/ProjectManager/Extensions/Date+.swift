//
//  Date+isEarlierThanToday.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/14.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()

    func isEarlierThanToday() -> Bool {
        let calendar = Calendar.current
        return calendar.startOfDay(for: self) < calendar.startOfDay(for: Date())
    }

    func localizedDateString() -> String {
        let dateFormatter = Self.dateFormatter
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.description)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}
