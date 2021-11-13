//
//  Extension+Date.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation.NSDate

extension Date {
    var formattedString: String {
        let deviceLocal = Locale(identifier: Locale.preferredLanguages[0])
        let dateFormmater = DateFormatter()
        dateFormmater.locale = deviceLocal
        dateFormmater.dateStyle = .long
        return dateFormmater.string(from: self)
    }
    
    var isAfterDue: Bool {
        let calender = Calendar.current
        let today = Date()
        return calender.compare(today, to: self, toGranularity: .day) == .orderedDescending
    }
}
