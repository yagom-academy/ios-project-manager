//
//  Date+.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/24.
//

import Foundation

extension Date {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        formatter.dateFormat = "yyyy. M. d."
        
        return formatter
    }()
    
    func applyDateFormatter() -> String {
        guard let value = Date.dateFormatter.string(for: self) else { return "0000. 0. 0." }
        
        return value
    }
}
