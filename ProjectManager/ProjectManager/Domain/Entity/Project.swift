//
//  Project.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import Foundation

enum State: String, CaseIterable {
    case toDo = "TODO"
    case doing = "DOING"
    case done = "DONE"
}

struct Project: Hashable {
    let id: UUID
    var title: String
    var body: String
    var deadline: Date
    var state: State
    
    init(id: UUID = UUID(), title: String, body: String, deadline: Date, state: State) {
        self.id = id
        self.title = title
        self.body = body
        self.deadline = deadline
        self.state = state
    }
}
