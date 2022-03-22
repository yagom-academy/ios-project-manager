//
//  Date+formatter.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import Foundation

extension Date {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var dateString: String {
        return Self.dateFormatter.string(from: self)
    }
    
    var isOverdue: Bool {
        let targetDate = Self.dateFormatter.date(from: self.dateString) ?? Date(timeIntervalSince1970: self.timeIntervalSince1970)
        let currentDate = Self.dateFormatter.date(from: Date().dateString) ?? Date()
        return targetDate < currentDate
    }
}
