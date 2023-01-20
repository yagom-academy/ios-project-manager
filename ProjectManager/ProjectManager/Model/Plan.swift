//
//  Plan.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/12.
//

import Foundation

struct Plan: Hashable {
    var title: String
    var content: String?
    var deadLine: Date?
    
    var convertDeadline: String {
        guard let deadLine = deadLine else { return "" }
        return DateFormatter.convertToString(deadLine)
    }
    
    var isOverDeadLine: Bool {
        let now = DateFormatter.convertToString(Date())
        if now > convertDeadline {
            return true
        }
        return false
    }
}
