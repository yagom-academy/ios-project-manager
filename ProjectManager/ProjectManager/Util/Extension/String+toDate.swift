//
//  String.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/22.
//

import Foundation

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        
        return date
    }
    
    func convertDateLocalization() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? "ko")
        
        return dateFormatter.string(from: self.toDate())
    }
}
