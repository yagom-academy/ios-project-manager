//
//  DatabaseManager.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/19.
//

import Foundation

import RxSwift
import RxRelay

protocol DatabaseManagerProtocol {
    var todoListBehaviorRelay: BehaviorRelay<[Todo]> { get }
    
    func create(todoData: Todo)
    func read()
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
    func isConnected() -> Observable<Bool>
}

final class DatabaseManager: DatabaseManagerProtocol {
    var todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])

    private let realm = RealmDatabase()
    private let firebase = FirebaseDatabase()
    
    init() {
        self.read()
    }
    
    func isConnected() -> Observable<Bool> {
            return self.firebase.isConnected()
        }
    
    func create(todoData: Todo) {
        self.realm.create(todoData: todoData) { [weak self] todoData in
            self?.firebase.create(todoData: todoData)
        }
        
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
    }

    func read() {
        self.realm.read { [weak self] todoData in
            self?.firebase.sync(todoData: todoData)
            self?.todoListBehaviorRelay.accept(todoData)
        }
    }

    func update(selectedTodo: Todo) {
        self.realm.update(selectedTodo: selectedTodo) { [weak self] selectedTodo in
            self?.firebase.update(selectedTodo: selectedTodo)
        }
        
        var todoList = self.todoListBehaviorRelay.value
        if let index = todoList.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoList[index] = selectedTodo
        }

        self.todoListBehaviorRelay.accept(todoList)
    }
    
    func delete(todoID: UUID) {
        self.realm.delete(todoID: todoID) { [weak self] uuid in
            self?.firebase.delete(todoID: uuid)
        }
        
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(items)
    }
    
    func backup() {
        self.firebase.read { [weak self] todo in
            self?.realm.add(todoData: todo)
        }
    }
}
