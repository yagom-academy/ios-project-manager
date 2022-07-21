//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/19.
//

import Foundation

import RxRelay

protocol DatabaseManagerProtocol {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get set }
    
    func create(todoData: Todo)
    func read()
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
}

final class DatabaseManager: DatabaseManagerProtocol {
    var todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])

    let realm = RealmDatabase()
    let firebase = FirebaseDatabase()
    
    init() {
        self.read()
    }
    
    func create(todoData: Todo) {
        self.realm.create(todoData: todoData)
        self.firebase.create(todoData: todoData)
        
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
    }

    func read() {
        self.todoListBehaviorRelay.accept(self.realm.read())
    }

    func update(selectedTodo: Todo) {
        self.realm.update(selectedTodo: selectedTodo)
        
        var todoArray = self.todoListBehaviorRelay.value
        if let index = todoArray.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoArray[index] = selectedTodo
        }

        self.todoListBehaviorRelay.accept(todoArray)
    }
    
    func delete(todoID: UUID) {
        self.realm.delete(todoID: todoID)
        
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(items)
    }
}
