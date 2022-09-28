//
//  DatabaseManger.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/19.
//

import Foundation
import RxRelay

class DatabaseManager: TodoDatabaseManager {
    var todoListViewBehaviorRelay = BehaviorRelay<[TodoModel]>(value: [])
    
    let realm = RealmDatabaseManager()
    
    init() {
        self.read()
    }
    
    func create(todoData: TodoModel) {
        self.realm.create(todoData: todoData)
        self.read()
    }
    
    func read() {
        self.todoListViewBehaviorRelay.accept(self.realm.read())
    }
    
    func update(updateTodoData: TodoModel) {
        self.realm.update(updateData: updateTodoData)
        self.read()
    }
    
    func delete(deleteTodoData: UUID) {
        self.realm.delete(deleteID: deleteTodoData)
        self.read()
    }
}
