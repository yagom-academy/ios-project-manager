//
//  Date+.swift
//  ProjectManager
//
//  Created by Jiyoung Lee on 2023/01/18.
//

import Foundation

extension Date {
    var dateOnly: Date? {
        let calendar = Calendar.current
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = .current
        return calendar.date(from: dateComponents)
    }
}
