//
//  DateFormatter.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import Foundation

extension DateFormatter {
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .long
        dateFormatter.locale = .autoupdatingCurrent
        
        return dateFormatter
    }
    
    func formatted(string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
    func formatted(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
