//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

extension DateFormatter {
    func numberToString(number: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: number)
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = "yyyy-MM-dd"
        
        return self.string(from: date)
    }
    
    func dateToNumber(date: Date) -> TimeInterval {
        return date.timeIntervalSince1970
    }
    
    func dateToString(date: Date) -> String {
        let numberOfDate = dateToNumber(date: date)
        let stringOfDate = numberToString(number: numberOfDate)
        
        return stringOfDate
    }
    
    func numberToDate(number: TimeInterval) -> Date {
        let stringOfDate = numberToString(number: number)
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = "yyyy-MM-dd"
        let date = self.date(from: stringOfDate)!
        
        return date
    }
}
