//
//  Task.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/01.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let deadline: Date
    let state: TaskState
    
    init(id: UUID = UUID(), title: String, description: String, deadline: Date, state: TaskState = .waiting) {
        self.id = id
        self.title = title
        self.description = description
        self.deadline = deadline
        self.state = state
    }
}
