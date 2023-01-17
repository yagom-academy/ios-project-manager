//
//  Double+Formatter.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

extension Double {
    var toDateString: String {
        let formatter = DateFormatter()
        let date = Date(timeIntervalSince1970: self)

        formatter.locale = Locale.current
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
}
