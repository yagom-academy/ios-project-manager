//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/22.
//

import Foundation

extension Date {

    var taskFormat: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }

    var historyFormat: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }

    var date: Date? {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let currentDate = Calendar.current.date(from: components)
        return currentDate
    }
}
