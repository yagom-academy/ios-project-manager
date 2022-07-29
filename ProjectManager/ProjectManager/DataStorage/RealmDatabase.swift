//
//  RealmService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift
import RxRelay

enum CRUDType {
    case create(at: Todo)
    case update(at: Todo)
    case delete(at: UUID)
    case read(at: [Todo])
}

final class RealmDatabase {
    let dataBehaviorRelay = BehaviorRelay<CRUDType>(value: .read(at: []))
    
    private let realm: Realm?

    
    init() {
        self.realm = try? Realm()
        self.read()
    }
    
    func create(todoData: Todo) {
        try? self.realm?.write { [weak self] in
            self?.realm?.add(todoData.todoDTO())
        }
        self.dataBehaviorRelay.accept(.create(at: todoData))
    }
    
    private func read() {
        var todoList: [Todo] = []
        self.realm?.objects(TodoDTO.self)
            .forEach { todoList.append($0.convertTodo()) }
        self.dataBehaviorRelay.accept(.read(at: todoList))
    }
    
    func update(selectedTodo: Todo) {
        try? self.realm?.write({ [weak self] in
            self?.realm?.add(selectedTodo.todoDTO(), update: .modified)
        })
        self.dataBehaviorRelay.accept(.update(at: selectedTodo))
    }
    
    func delete(todoID: UUID) {
        guard let item = self.realm?.object(ofType: TodoDTO.self, forPrimaryKey: todoID) else {
            return
        }
        try? self.realm?.write({ [weak self] in
            self?.realm?.delete(item)
            
        })
        self.dataBehaviorRelay.accept(.delete(at: todoID))
    }
    
    func add(todoData: [Todo]) {
        let todoDataCollection = todoData.map { $0.todoDTO() }
        try? self.realm?.write({ [weak self] in
            self?.realm?.add(todoDataCollection, update: .all)
        })
    }
}
