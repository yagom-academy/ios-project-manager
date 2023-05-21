//
//  extension+DateFormatter.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import Foundation

extension DateFormatter {
    static let shared = DateFormatter()
    
    func stringDate(from date: Date) -> String {
        DateFormatter.shared.dateFormat = "yyyy. MM. dd."
        
        let convertedDate = DateFormatter.shared.string(from: date)
        
        return convertedDate
    }
}
