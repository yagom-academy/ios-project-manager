//
//  Task.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/02.
//

import Foundation

class Task: Identifiable, Equatable {
    
    let id: String
    var title: String
    var body: String
    var dueDate: Date
    var status: TaskStatus
    
    init(title: String, body: String, dueDate: Date) {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.status = .todo
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
