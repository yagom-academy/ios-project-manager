//
//  Task.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

struct Task: Identifiable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
    var state: TaskState
    
    init(
        id: UUID = UUID(),
        title: String = "",
        content: String = "",
        date: Date = .now,
        state: TaskState = .todo
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.state = state
    }
}

enum TaskState: Int, CaseIterable {
    case todo = 1, doing, done
    
    var title: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
