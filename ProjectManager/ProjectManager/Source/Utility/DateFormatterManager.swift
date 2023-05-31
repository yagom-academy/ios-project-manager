//
//  DateFormatterManager.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/22.
//

import Foundation

final class DateFormatterManager {
    static let shared = DateFormatterManager()
    private let dateFormatter = DateFormatter()
    
    private init() {}
    
    func convertToDate(from date: Date) -> String {
        dateFormatter.dateFormat = "yyyy. MM. dd."
        
        return dateFormatter.string(from: date)
    }
}
