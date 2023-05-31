//
//  DateManager.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/26.
//

import Foundation

enum DateFormat {
    case display
    case calculate
    
    var expression: String {
        switch self {
        case .display:
            return "yyyy. M. d."
        case .calculate:
            return "yyyyMMdd"
        }
    }
}

final class DateManager {
    static let shared = DateManager()
    
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        
        return dateFormatter
    }()
    
    private init() { }
    
    func formatDateText(date: Date, mode: DateFormat) -> String {
        if mode == .display {
            dateFormatter.dateFormat = DateFormat.display.expression
            
            return dateFormatter.string(from: date)
        } else {
            dateFormatter.dateFormat = DateFormat.calculate.expression
            
            return dateFormatter.string(from: date)
        }
    }

    func checkDeadline(date: Date) -> Bool {
       let today = convertDateToInt(date: Date())
       let target = convertDateToInt(date: date)
        
        return target >= today
    }
    
    private func convertDateToInt(date: Date) -> Int {
        let formattedText = formatDateText(date: date, mode: .calculate)

        return Int(formattedText)!
    }
}
