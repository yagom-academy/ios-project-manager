//
//  DateFormatManager.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/24.
//

import Foundation

struct CurrentDateFormatManager {
    
    // MARK: - Static Property
    static let shared = CurrentDateFormatManager()
    
    // MARK: - Private Property
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    private init() { }
    
    func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func date(from string: String) -> Date {
        return dateFormatter.date(from: string) ?? Date()
    }
}
