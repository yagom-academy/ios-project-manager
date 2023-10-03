//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by 박종화 on 2023/10/02.
//

import Foundation

struct DateFormatManager {
    static let customDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "koKR")
        dateFormatter.dateFormat = "YYYY. MM. dd."
        
        return dateFormatter
    }()
    
    static func formatDate(date: Date) -> String {
        let formattedDate = customDateFormatter.string(from: date)
        
        return formattedDate
    }
}
