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
        self.todoListViewBehaviorRelay.accept(self.todoListViewBehaviorRelay.value + [todoData])
    }
    
    func read() {
        self.todoListViewBehaviorRelay.accept(self.realm.read())
    }
    
    func update(updateTodoData: TodoModel) {
        self.realm.update(updateData: updateTodoData)
        
        var todoList = self.todoListViewBehaviorRelay.value
        if let todoindex = todoList.firstIndex(where: { $0.id == updateTodoData.id}) {
            todoList[todoindex] = updateTodoData
        }
        self.todoListViewBehaviorRelay.accept(todoList)
    }
    
    func delete(deleteTodoData: UUID) {
        self.realm.delete(deleteID: deleteTodoData)
        
        let deleteTodoData = self.todoListViewBehaviorRelay.value.filter({ $0.id != deleteTodoData })
        self.todoListViewBehaviorRelay.accept(deleteTodoData)
    }
}
