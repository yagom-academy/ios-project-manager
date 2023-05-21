//
//  Date+extension.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/21.
//
import Foundation

extension Date {
    static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let dateString = {
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
}
