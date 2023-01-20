//  ProjectManager - ToDo.swift
//  created by zhilly on 2023/01/13

import Foundation

struct ToDo: Hashable {
    var id: UUID = UUID()
    var title: String
    var body: String
    var deadline: Date
    var state: ToDoState
    
    init(title: String, body: String, deadline: Date, state: ToDoState) {
        self.title = title
        self.body = body
        self.deadline = deadline
        self.state = state
    }

    var isOverDeadline: Bool {
        return deadline < Date()
    }
}
