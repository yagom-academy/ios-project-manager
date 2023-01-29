//
//  Date+.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/18.
//

import Foundation

extension Date {
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        dateComponents.timeZone = .current
        return dateComponents
    }
    
    var isOverdue: Bool {
        let calendar = Calendar.current
        let deadline = self.dateComponents
        let today = Date().dateComponents
        
        guard let remainingDays = calendar.dateComponents([.day], from: today, to: deadline).day else { return false }
        return remainingDays < .zero ? true : false
    }
}
