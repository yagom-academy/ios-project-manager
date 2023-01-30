//
//  Date+.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/17.
//

import Foundation

extension Date {
    func convertDateToDouble() -> Double {
        return self.timeIntervalSince1970
    }
    
    var customDescription: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DatePickerValue.dateFormat
        
        let localeLanguage = Locale.preferredLanguages.first
        dateFormatter.locale = Locale(identifier: localeLanguage ?? DatePickerValue.locale)
        dateFormatter.timeZone = TimeZone(abbreviation: DatePickerValue.timezone)
        
        return dateFormatter.string(from: self)
    }
}
