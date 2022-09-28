//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/13.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        return dateFormatter.string(from: self)
    }
    
    func convertLocalization() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
        
        return dateFormatter.string(from: self)
    }
}
