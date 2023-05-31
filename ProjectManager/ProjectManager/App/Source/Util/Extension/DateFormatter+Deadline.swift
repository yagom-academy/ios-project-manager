//
//  DateFormatter+Deadline.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/23.
//

import Foundation

extension DateFormatter {
    static let deadlineFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY.MM.dd"
        
        return dateFormatter
    }()
    
    static func deadlineText(_ timeInterval: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        return deadlineFormatter.string(from: date)
    }
    
    static func deadlineDate(text: String) -> Date? {
        return deadlineFormatter.date(from: text)
    }
    
    static func currentDate() -> Date? {
        let date = deadlineFormatter.string(from: Date())
        return deadlineDate(text: date)
    }
}

extension DateFormatter {
    static let historyFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }()
    
    static func historyText(date: Date) -> String {
        return historyFormatter.string(from: date)
    }
}
