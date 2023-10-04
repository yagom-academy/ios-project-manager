//
//  TodoDateFormatter.swift
//  ProjectManager
//
//  Created by Moon on 2023/09/28.
//

import Foundation

enum DateFormat: String {
    case todo = "yyyy. M. d."
}

final class TodoDateFormatter {
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.todo.rawValue
        
        return formatter
    }()
    
    private init() { }
    
    static func string(from date: Date, format: DateFormat) -> String {
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.string(from: date)
    }
}
