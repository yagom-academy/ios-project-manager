//
//  Project.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/16.
//

import Foundation

struct Project: Hashable {
    let id: UUID
    var title: String
    var deadline: Date
    var description: String
    var state: State
    
    init(id: UUID = UUID(), title: String, deadline: Date, description: String, state: State) {
        self.id = id
        self.title = title
        self.deadline = deadline
        self.description = description
        self.state = state
    }
}
