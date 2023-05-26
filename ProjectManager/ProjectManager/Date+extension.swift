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
