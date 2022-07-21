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
    
    func create(todoData: Todo) {
        try? realm?.write {
            realm?.add(todoData.convertRealmTodo())
        }
    }
    
    func read() -> [Todo] {
        var todoArray: [Todo] = []
        realm?.objects(TodoDTO.self).forEach { todoArray.append($0.convertTodo()) }
        
        return todoArray
    }
    
    func update(selectedTodo: Todo) {
        try? realm?.write({
            realm?.add(selectedTodo.convertRealmTodo(), update: .modified)
        })
    }
    
    func delete(todoID: UUID) {
        guard let item = realm?.object(ofType: TodoDTO.self, forPrimaryKey: todoID) else {
            return
        }
        
        try? realm?.write({
            realm?.delete(item)
        })
    }
    
    func add(todoData: [Todo]) {
        let todoDataCollection = todoData.map { $0.convertRealmTodo() }
        try? realm?.write({
            realm?.add(todoDataCollection, update: .all)
        })
    }
}
