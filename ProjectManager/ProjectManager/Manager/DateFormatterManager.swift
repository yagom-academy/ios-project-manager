//
//  DateFormatterManager.swift
//  ProjectManager
//
//  Created by goat on 2023/05/19.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    private init() { }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: Locale.current.identifier)
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    func convertDateToString(date: Date) -> String? {
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let convertedDate = dateFormatter.string(from: date)
        return convertedDate
    }
}
