//
//  History.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import Foundation

enum Changes: String {
    case moved = "Moved"
    case added = "Added"
    case removed = "Removed"
}

struct History {
    let changes: Changes
    let title: String
    let beforeState: State?
    let afterState: State?
    let id: UUID
    
    init(changes: Changes, title: String, beforeState: State? = nil, afterState: State? = nil, id: UUID) {
        self.changes = changes
        self.title = title
        self.beforeState = beforeState
        self.afterState = afterState
        self.id = id
    }
}
