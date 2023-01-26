//
//  Calendar +.swift
//  ProjectManager
//  Created by inho on 2023/01/19.
//

import Foundation

extension Calendar {
    static func calculateHourUntilToday(_ date: Date) -> Int {
        guard let currentHour = Calendar.current.dateComponents([.hour], from: date).hour else {
            return 0
        }
        
        let hourIntervalUntilToday = 23 - currentHour
        
        return hourIntervalUntilToday
    }
    
    static func changeHourUntilToday(value: Int, _ date: Date) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: value, to: date)
    }
}
