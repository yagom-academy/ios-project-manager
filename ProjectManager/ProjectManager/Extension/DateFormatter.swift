//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 강경 on 2021/06/29.
//

import Foundation

extension DateFormatter {
    func dateToString(
        date: Date,
        dateFormat: DateFormat
    ) -> String {
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = dateFormat.rawValue
        
        return self.string(from: date)
    }
    
    func stringToDate(
        string: String,
        dateFormat: DateFormat
    ) -> Date {
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = dateFormat.rawValue
        
        // TODO: - 보다 클린한 코딩을 위해 고민해보자..
        var dateString = string
        if string.count == 10 {
            dateString += "T00:00:00Z"
        }
        guard let date = self.date(from: dateString)
        else {
            print("date에 이상한 String이 들어갔음..")
            print("String: \(dateString)")
            
            return Date()
        }
        
        return date
    }
    
    func changeStringDateFormat(
        date: String,
        beforeDateFormat: DateFormat,
        afterDateFormat: DateFormat
    ) -> String {
        let date = stringToDate(
            string: date,
            dateFormat: beforeDateFormat
        )
        self.locale = Locale(identifier: Locale.current.identifier)
        self.dateFormat = afterDateFormat.rawValue
        
        return self.string(from: date)
    }
}
