//
//  SampleModel.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation

struct TodoModel {
    let id: UUID = UUID()
    let category: TodoCategory
    let title: String
    let body: String
    let createdAt: Date
    
    init(category: TodoCategory, title: String, body: String, createdAt: Date) {
        self.category = category
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
}
