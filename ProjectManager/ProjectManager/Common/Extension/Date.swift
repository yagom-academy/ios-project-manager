//
//  Date.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/08.
//

import Foundation

extension Date {
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "yyyy. M. d."
        return formatter.string(from: self)
    }
    
    var endOfTheDay: Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: self)
        
        components.hour = 23
        components.minute = 59
        
        return calendar.date(from: components)
    }
}
