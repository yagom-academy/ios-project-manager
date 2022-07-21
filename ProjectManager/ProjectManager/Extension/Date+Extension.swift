//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import Foundation

extension Date {
    static let dateFormatter = DateFormatter()
    
    var formattedString: String {
        Date.dateFormatter.dateStyle = .medium
        Date.dateFormatter.locale = .current
        return Date.dateFormatter.string(from: self)
    }
    
    var isoDateString: String {
        Date.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        Date.dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return Date.dateFormatter.string(from: self)
    }
    
    static let today = Date()
}
