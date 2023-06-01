//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/23.
//

import Foundation

extension Date {
    private static let listDateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY. MM. dd."
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    private static let historyDateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY. MM. dd. hh:mm a"
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    var formatedListDateText: String {
        return Date.listDateFormatter.string(from: self)
    }
    
    var formatedHistoryDateText: String {
        return Date.historyDateFormatter.string(from: self)
    }
}
