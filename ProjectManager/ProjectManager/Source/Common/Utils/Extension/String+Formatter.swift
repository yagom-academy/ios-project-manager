//
//  String+Formatter.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

extension String {
    var toDate: Date? {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        formatter.dateStyle = .long
        
        return formatter.date(from: self)
    }
}
