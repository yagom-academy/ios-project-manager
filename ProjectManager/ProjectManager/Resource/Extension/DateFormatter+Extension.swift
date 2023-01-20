//  ProjectManager - DateFormatter+Extension.swift
//  created by zhilly on 2023/01/19

import Foundation

extension DateFormatter {
    static func convert(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: date)
    }
}
