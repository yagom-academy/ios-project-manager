//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 강민수 on 2023/05/23.
//

import Foundation

extension Date {
    private static let dateFormatter = {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "YYYY. MM. dd."
        formatter.locale = Locale.current
        
        return formatter
    }()
    
    var formattedText: String {
        return Date.dateFormatter.string(from: self)
    }
}
