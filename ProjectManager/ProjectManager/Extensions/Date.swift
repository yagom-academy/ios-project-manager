//
//  Date.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/17.
//

import Foundation

let secondsADay: TimeInterval = 86400

extension Date {
    var isExpired: Bool {
        switch self.compare(Date().addingTimeInterval(-secondsADay)) {
        case .orderedAscending:
            return true
        default:
            return false
        }
    }

    func convertToString(using dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }

    func convertToString(format string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self)
    }
}
