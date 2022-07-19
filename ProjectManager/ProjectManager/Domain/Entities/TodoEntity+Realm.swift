//
//  TodoEntity+Realm.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/19.
//

import Foundation
import RealmSwift

final class TodoEntity: Object {
    @Persisted private var title: String?
    @Persisted private var body: String?
    @Persisted private var deadlineAt: Date
    @Persisted private var state: String
    @Persisted(primaryKey: true) var id: UUID
    
    convenience init(entity: TodoModel) {
        self.init()
        self.title = entity.title
        self.body = entity.body
        self.deadlineAt = entity.deadlineAt
        self.state = entity.state.rawValue
        self.id = entity.id
    }
    
    func toTodoModel() -> TodoModel {
        return TodoModel(title: title,
                         body: body,
                         deadlineAt: deadlineAt,
                         state: State(rawValue: state) ?? .todo,
                         id: id)
    }
    
    func updateEntity(entity: TodoModel) {
        title = entity.title
        body = entity.body
        deadlineAt = entity.deadlineAt
        state = entity.state.rawValue
    }
}
