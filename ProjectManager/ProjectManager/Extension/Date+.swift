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
        dateFormatter.dateFormat = "yyyy. M. d."
        
        let localeLanguage = Locale.preferredLanguages.first
        dateFormatter.locale = Locale(identifier: localeLanguage ?? "ko-kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        return dateFormatter.string(from: self)
    }
}
