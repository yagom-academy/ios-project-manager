//
//  SampleModel.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/13.
//

import Foundation
import RealmSwift

class TodoEntityModel: Object {
    @Persisted dynamic var id: UUID
    @Persisted dynamic var category: String
    @Persisted dynamic var title: String
    @Persisted dynamic var body: String
    @Persisted dynamic var createdAt: Date
    
    convenience init(id: UUID, category: TodoCategory, title: String, body: String, createdAt: Date) {
        self.init()
        self.id = id
        self.category = category.rawValue
        self.title = title
        self.body = body
        self.createdAt = createdAt
    }
    
    func convertTodoModel() -> TodoModel {
        return TodoModel(id: self.id, category: TodoCategory(rawValue: self.category) ?? .todo, title: self.title, body: self.body, createdAt: self.createdAt)
    }
}
