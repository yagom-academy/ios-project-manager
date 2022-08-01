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
    
    func create(todoData: Todo)
    func update(selectedTodo: Todo)
    func delete(todoID: UUID)
    func isConnected() -> Observable<Bool>
    func isHistoryEmpty() -> Observable<Bool>
    func deleteHistory()
}

final class DatabaseManager: DatabaseManagerProtocol {
    let todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    let historyBehaviorRelay = BehaviorRelay<[History]>(value: [])
    
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
    
    func isHistoryEmpty() -> Observable<Bool> {
        return Observable.create { observer in
            let _ = self.historyBehaviorRelay.subscribe(onNext: { history in
                if history.isEmpty {
                    observer.onNext(false)
                } else {
                    observer.onNext(true)
                }
            })
            return Disposables.create()
        }
    }
    
    func create(todoData: Todo) {
        self.realm.create(todoData: todoData)
        
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [todoData.createHistory(action: .added)])
    }
    
    func read(identifier: UUID) -> Todo? {
        return self.todoListBehaviorRelay.value.filter({ $0.identifier == identifier }).first
    }
    
    func update(selectedTodo: Todo) {
        self.realm.update(selectedTodo: selectedTodo)
        
        var todoList = self.todoListBehaviorRelay.value
        
        if let index = todoList.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoList[index] = selectedTodo
        }
        
        guard let todoItem = self.read(identifier: selectedTodo.identifier) else {
            return
        }

        if selectedTodo.todoListItemStatus == todoItem.todoListItemStatus {
            self.edit(nextTodo: selectedTodo, previousTodo: todoItem)
        } else {
            self.move(nextTodo: selectedTodo, previousTodo: todoItem)
        }
        
        self.todoListBehaviorRelay.accept(todoList)
    }
    
    private func edit(nextTodo: Todo, previousTodo: Todo) {
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [nextTodo.createHistory(action: .edited, previousTodo: previousTodo)])
    }

    private func move(nextTodo: Todo, previousTodo: Todo) {
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [nextTodo.createHistory(action: .moved, previousTodo: previousTodo)])
    }
    
    func delete(todoID: UUID) {
        self.realm.delete(todoID: todoID)
        
        let todoItems = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        guard let todoItem = read(identifier: todoID) else { return }

        self.todoListBehaviorRelay.accept(todoItems)
        self.historyBehaviorRelay.accept(self.historyBehaviorRelay.value + [todoItem.createHistory(action: .removed)])
    }
    
    func deleteHistory() {
        for _ in 0...1 {
            let history = self.historyBehaviorRelay.value.last
            let historyItems = self.historyBehaviorRelay.value.filter { history != $0 }
            self.historyBehaviorRelay.accept(historyItems)
        }
    }
    
    func backup() {
        self.firebase.read { [weak self] todo in
            self?.realm.add(todoData: todo)
        }
    }
}
