//
//  Formatter.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/10.
//

import Foundation

struct Formatter {
    static let date: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .autoupdatingCurrent
        
        return dateFormatter
    }()
    
    private init() {}
}

extension DateFormatter {
    func fetchCurrentDate() -> Date {
        guard let currentDate = Formatter.date.date(from: Date().description) else {
            return Date()
        }
        return currentDate
    }
}
