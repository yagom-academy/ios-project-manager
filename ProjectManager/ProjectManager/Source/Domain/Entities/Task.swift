//
//  Task.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

struct Task {
    let id: String
    var title: String
    var content: String
    var deadLine: Double
    var state: State
    var isExpired: Bool
    
    enum State: Int, CaseIterable {
        case toDo
        case doing
        case done
    }
    
    init(
        id: String = UUID().uuidString,
        title: String,
        content: String,
        deadLine: Double,
        state: State = .toDo
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.deadLine = deadLine
        self.state = state
        self.isExpired = deadLine < Date.startOfCurrentDay.timeIntervalSince1970
    }
}

extension Task: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (_ lhs: Self, _ rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
