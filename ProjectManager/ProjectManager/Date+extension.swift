//
//  Date+extension.swift
//  ProjectManager
//
//  Created by Andrew on 2023/05/21.
//
import UIKit

extension Date {
    static let dateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let dateString = {
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }()
    
    static func setCustomDate(year: Int, month: Int, day: Int) -> String {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        guard let customDate = calendar.date(from: dateComponents) else {
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: customDate)
        return dateString
    }
    
    func dateCompare(fromDate: Date) -> UIColor {
        var deadlineColor = UIColor.black
        let result: ComparisonResult = self.compare(fromDate)
        switch result {
        case .orderedDescending:
            deadlineColor = .red
            break
        default:
            break
        }
        return deadlineColor
    }
}
