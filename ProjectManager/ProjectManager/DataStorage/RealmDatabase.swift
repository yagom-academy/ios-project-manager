//
//  RealmService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift

final class RealmDatabase {
    private var realm: Realm?
    
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
        let item = realm?.objects(TodoDTO.self)
            .filter({ $0.identifier == selectedTodo.identifier })
            .first
        
        if item != nil {
            try? realm?.write({
                item?.todoListItemStatus = selectedTodo.todoListItemStatus.displayName
                item?.identifier = selectedTodo.identifier
                item?.title = selectedTodo.title
                item?.body = selectedTodo.description
                item?.date = selectedTodo.date
            })
        }
    }
    
    func delete(todoID: UUID) {
        guard let item = realm?.objects(TodoDTO.self).filter({ $0.identifier == todoID }).first else {
            return
        }
        
        try? realm?.write({
            realm?.delete(item)
        })
    }
}
