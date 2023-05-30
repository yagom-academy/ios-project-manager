//
//  extension+DateFormatter.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/19.
//

import Foundation

extension DateFormatter {
    func stringDate(from date: Date) -> String {
        dateFormat = "yyyy. MM. dd."
        let convertedDate = string(from: date)
        
        return convertedDate
    }
}
