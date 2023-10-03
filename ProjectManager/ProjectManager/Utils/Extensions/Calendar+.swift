//
//  Calendar+.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/26.
//

import Foundation

extension Calendar {
    
    // MARK: - Static Function
    static func compareDate(_ lhs: Date, with rhs: Date) -> Bool {
        let calendar = Calendar.current
        let selectedDateComponents = calendar.dateComponents([.year, .month, .day], from: lhs)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: rhs)
        
        return calendar.date(from: selectedDateComponents)! < calendar.date(from: currentDateComponents)!
    }
}
