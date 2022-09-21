//
//  DatabaseManger.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/19.
//

import Foundation

class DatabaseManager: TodoDatabaseManager {
    var todoList: [TodoModel] = []
    let realm = RealmDatabaseManager()
    
    func create(todoData: TodoModel) {
        self.realm.create(todoData: todoData)
    }
    
    func read() -> [TodoModel] {
        todoList = self.realm.read()
        return todoList
    }
    
    func update(updateTodoData: TodoModel) -> Bool {
        return self.realm.update(updateData: updateTodoData)
    }
    
    func delete(deleteTodoData: UUID) -> Bool {
        return self.realm.delete(deleteID: deleteTodoData)
    }
}
