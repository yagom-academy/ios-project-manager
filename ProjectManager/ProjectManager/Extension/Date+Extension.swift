//
//  Date+Extension.swift
//  ProjectManager
//
//  Created by 우롱차, 파프리 on 06/07/2022.
//

import Foundation

extension Date {
    var formattedString: String {
        DateFormatter.shared.dateStyle = .medium
        DateFormatter.shared.locale = .current
        return DateFormatter.shared.string(from: self)
    }
    
    var isoDateString: String {
        DateFormatter.shared.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        DateFormatter.shared.locale = Locale(identifier: "en_US_POSIX")
        return DateFormatter.shared.string(from: self)
    }
    
    var isoFormattedlongString: String {
        DateFormatter.shared.timeStyle = .medium
        DateFormatter.shared.locale = .current
        return DateFormatter.shared.string(from: self)
    }
    
    static let today = Date()
}
