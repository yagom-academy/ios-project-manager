//  ProjectManager - DateFormatter+Extension.swift
//  created by zhilly on 2023/01/19

import Foundation

extension DateFormatter {
    static func convertToString(to date: Date, style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        
        return dateFormatter.string(from: date)
    }
}
