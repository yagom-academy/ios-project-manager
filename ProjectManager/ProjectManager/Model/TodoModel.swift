//
//  SampleModel.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation

struct TodoModel {
    let id: UUID
    let category: TodoCategory
    let title: String
    let body: String
    let createdAt: Date
    
    init(id: UUID, category: TodoCategory, title: String, body: String, createdAt: Date) {
        self.id = id
        self.category = category
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
    
    func convertDatabaseTodo() -> TodoEntityModel {
        return TodoEntityModel(id: self.id, category: self.category, title: self.title, body: self.body, createdAt: self.createdAt)
    }
}
