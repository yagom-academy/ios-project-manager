//
//  DateManager.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/12.
//

import Foundation

final class DateManager {
    static let shared = DateManager()
    private init() {}
    
    private let dateformatter = DateFormatter()
    
    func formattedString(_ date: Date) -> String {
        dateformatter.locale = .current
        dateformatter.dateFormat = "yyyy. M. d."
        return dateformatter.string(from: date)
    }
    
    func endOfTheDay(for date: Date) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: date)
        
        components.hour = 23
        components.minute = 59
        
        return calendar.date(from: components)
    }
}
