//
//  TodoDTO.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift

final class TodoDTO: Object {
    @Persisted (primaryKey: true) var identifier: UUID
    @Persisted var todoListItemStatus: String
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var date: Date
    
    convenience init(
        todoListItemStatus: TodoListItemStatus,
        identifier: UUID,
        title: String,
        body: String,
        date: Date
    ) {
        self.init()
        self.todoListItemStatus = todoListItemStatus.displayName
        self.identifier = identifier
        self.title = title
        self.body = body
        self.date = date
    }
    
    func todo() -> Todo {
        return Todo(
            todoListItemStatus: TodoListItemStatus(rawValue: self.todoListItemStatus) ?? .todo,
            identifier: self.identifier,
            title: self.title,
            description: self.body,
            date: self.date
        )
    }
}
