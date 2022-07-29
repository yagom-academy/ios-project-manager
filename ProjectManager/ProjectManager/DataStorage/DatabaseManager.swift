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
    var historyBehaviorRelay: BehaviorRelay<[History]> { get }
    var undoBehaviorRelay: BehaviorRelay<[History]> { get }
    
    func create(todoData: Todo)
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
    func isConnected() -> Observable<Bool>
}

final class DatabaseManager: DatabaseManagerProtocol {
    let todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    let historyBehaviorRelay = BehaviorRelay<[History]>(value: [])
    let undoBehaviorRelay = BehaviorRelay<[History]>(value: [])
    
    private let realm = RealmDatabase()
    private let firebase = FirebaseDatabase()
    private let disposeBag = DisposeBag()
    
    init() {
        self.bind()
    }
    
    private func bind() {
        self.realm.dataBehaviorRelay.subscribe(onNext: { CRUDType in
            switch CRUDType {
            case .create(at: let todoData):
                self.firebase.create(todoData: todoData)
            case .update(at: let selectedTodoData):
                self.firebase.update(selectedTodo: selectedTodoData)
            case .delete(at: let selectedTodoData):
                self.firebase.delete(todoID: selectedTodoData)
            case .read(at: let todoDataList):
                self.firebase.sync(todoData: todoDataList)
                self.todoListBehaviorRelay.accept(todoDataList)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    func isConnected() -> Observable<Bool> {
        return self.firebase.isConnected()
    }
    
    func create(todoData: Todo) {
        self.realm.create(todoData: todoData)
        
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [todoData.history(action: .added, status: .from(currentStatus: .todo))])
    }
    
    func update(selectedTodo: Todo) {
        self.realm.update(selectedTodo: selectedTodo)
        
        var todoList = self.todoListBehaviorRelay.value
        guard let todoItem = todoList.filter({ $0.identifier == selectedTodo.identifier }).first else {
            return
        }
        
        if selectedTodo.todoListItemStatus == todoItem.todoListItemStatus {
            self.edit(lastTodo: todoItem)
        } else {
            self.move(todoItem, to: selectedTodo.todoListItemStatus)
        }
        
        if let index = todoList.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoList[index] = selectedTodo
        }
        self.todoListBehaviorRelay.accept(todoList)
    }
    
    private func edit(lastTodo: Todo) {
        let history = lastTodo.history(
            action: .edited,
            status: .from(currentStatus: lastTodo.todoListItemStatus)
        )
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [history])
    }
    
    private func move(_ selectedTodo: Todo, to currentStatus: TodoListItemStatus) {
        let history = selectedTodo.history(
            action: .moved,
            status: .move(lastStatus: selectedTodo.todoListItemStatus, currentStatus: currentStatus)
        )
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [history])
    }
    
    func delete(todoID: UUID) {
        self.realm.delete(todoID: todoID)
        
        guard let todoItem = self.todoListBehaviorRelay.value.filter({ $0.identifier == todoID }).first else {
            return
        }
        
        let history = todoItem.history(action: .removed, status: .from(currentStatus: todoItem.todoListItemStatus))
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [history])
        
        let todoItems = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(todoItems)
    }
    
    func backup() {
        self.firebase.read { [weak self] todo in
            self?.realm.add(todoData: todo)
        }
    }
}
