//
//  Date+.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/25.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()
    
    func convertString() -> String {
        let formatter = Self.dateFormatter
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy. MM. dd"
        
        return formatter.string(from: self)
    }
}
