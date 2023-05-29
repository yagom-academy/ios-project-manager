//
//  DateManager.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/26.
//

import Foundation

final class DateManager {
    private let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. M. d."
        
        return dateFormatter
    }()
    
    static let shared = DateManager()
    
    private init() { }
    
    func formatDateText(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func checkDeadline(date: Date) -> Bool {
       let today = convertDateToInt(date: Date())
       let target = convertDateToInt(date: date)
        
        if target < today {
            return false
        } else {
            return true
        }
    }
    
    private func convertDateToInt(date: Date) -> Int {
        let formattedText = formatDateText(date: date)
        let dateText = formattedText.components(separatedBy: ".").map{ $0.trimmingCharacters(in: .whitespaces) }.joined()

        return Int(dateText)!
    }
}
