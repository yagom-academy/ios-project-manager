//
//  DateFormatter+Extension.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

extension DateFormatter {
    static func convertToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.DD"
        return formatter.string(from: date)
    }
}
