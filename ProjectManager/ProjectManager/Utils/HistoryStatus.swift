//
//  HistoryStatus.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/22.
//

import Foundation

enum HistoryStatus {
    case from(currentStatus: TodoListItemStatus)
    case move(lastStatus: TodoListItemStatus, currentStatus: TodoListItemStatus)
    
    var value: String {
        switch self {
        case .from(let currentStatus):
            return "from \(currentStatus.displayName)"
        case .move(let lastStatus, let currentStatus):
            return "from \(lastStatus.displayName) to \(currentStatus.displayName)"
        }
    }
}
