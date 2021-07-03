//
//  DateConverter.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

final class DateConverter {
    func numberToString(number: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: number)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date)
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
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringOfDate)!
        
        return date
    }
}
