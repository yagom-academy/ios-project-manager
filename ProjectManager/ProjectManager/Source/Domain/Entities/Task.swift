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
    
    enum State: Int {
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
