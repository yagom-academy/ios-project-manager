//
//  DateFormatter +.swift
//  ProjectManager
//  Created by inho on 2023/01/17.
//

import Foundation

extension DateFormatter {
    static let listDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd."
        
        return formatter
    }()
}
