//
//  Date.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import Foundation

extension Date {
    var string: String {
        return dateFormatter.string(from: self)
    }

    var isExpired: Bool {
        switch self.compare(Date().addingTimeInterval(-86400)) {
        case .orderedAscending:
            return true
        default:
            return false
        }
    }
}
