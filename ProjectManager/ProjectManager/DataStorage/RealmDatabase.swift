//
//  RealmService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift
import RxRelay

final class RealmDatabase {
    private let realm: Realm?
    
    let createDataPublishRelay = PublishRelay<Todo>()
    let updateDataPublishRelay = PublishRelay<Todo>()
    let deleteDataPublishRelay = PublishRelay<UUID>()
    
    init() {
        self.realm = try? Realm()
    }
    
    func create(todoData: Todo) {
        try? self.realm?.write { [weak self] in
            self?.realm?.add(todoData.convertRealmTodo())
        }
        self.createDataPublishRelay.accept(todoData)
    }
    
    func read(completion: @escaping ([Todo]) -> Void) {
        var todoList: [Todo] = []
        self.realm?.objects(TodoDTO.self)
            .forEach { todoList.append($0.convertTodo()) }
        completion(todoList)
    }
    
    func update(selectedTodo: Todo) {
        try? self.realm?.write({ [weak self] in
            self?.realm?.add(selectedTodo.convertRealmTodo(), update: .modified)
        })
        self.updateDataPublishRelay.accept(selectedTodo)
    }
    
    func delete(todoID: UUID) {
        guard let item = self.realm?.object(ofType: TodoDTO.self, forPrimaryKey: todoID) else {
            return
        }
        try? self.realm?.write({ [weak self] in
            self?.realm?.delete(item)
            
        })
        self.deleteDataPublishRelay.accept(todoID)
    }
    
    func add(todoData: [Todo]) {
        let todoDataCollection = todoData.map { $0.convertRealmTodo() }
        try? self.realm?.write({ [weak self] in
            self?.realm?.add(todoDataCollection, update: .all)
        })
    }
}
