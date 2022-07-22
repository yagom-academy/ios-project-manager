//
//  RealmService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift

final class RealmDatabase {
    private let realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func create(todoData: Todo, completion: @escaping (Todo) -> Void) {
        try? self.realm?.write {
            self.realm?.add(todoData.convertRealmTodo())
            completion(todoData)
        }
    }
    
    func read(completion: @escaping ([Todo]) -> Void) {
        var todoArray: [Todo] = []
        self.realm?.objects(TodoDTO.self)
            .forEach { todoArray.append($0.convertTodo()) }
        completion(todoArray)
    }
    
    func update(selectedTodo: Todo, completion: @escaping (Todo) -> Void) {
        try? self.realm?.write({
            self.realm?.add(selectedTodo.convertRealmTodo(), update: .modified)
            completion(selectedTodo)
        })
    }
    
    func delete(todoID: UUID, completion: @escaping (UUID) -> Void) {
        guard let item = self.realm?.object(ofType: TodoDTO.self, forPrimaryKey: todoID) else {
            return
        }
        
        try? self.realm?.write({
            self.realm?.delete(item)
            completion(todoID)
        })
    }
    
    func add(todoData: [Todo]) {
        let todoDataCollection = todoData.map { $0.convertRealmTodo() }
        try? self.realm?.write({
            self.realm?.add(todoDataCollection, update: .all)
        })
    }
}
