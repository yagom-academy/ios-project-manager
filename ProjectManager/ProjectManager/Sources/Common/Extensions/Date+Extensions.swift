//
//  Date+extension.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import Foundation

extension Date {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}
