//
//  RealmService.swift
//  ProjectManager
//
//  Created by 김동욱 on 2022/07/18.
//

import Foundation

import RealmSwift
import RxRelay

final class RealmDatabase: Database {
    var todoListBehaviorRelay = BehaviorRelay<[Todo]>(value: [])
    
    init() {
        self.read()
    }
    
    func create(todoData: Todo) {
        let realm = try? Realm()
        
        try? realm?.write {
            realm?.add(todoData.convertRealmTodo())
        }
        self.todoListBehaviorRelay.accept(self.todoListBehaviorRelay.value + [todoData])
    }
    
    func read() {
        let realm = try? Realm()
        var todoArray: [Todo] = []
        realm?.objects(RealmTodo.self).forEach { todoArray.append($0.convertTodo()) }
        self.todoListBehaviorRelay.accept(todoArray)
    }
    
    func update(selectedTodo: Todo) {
        let realm = try? Realm()
        let item = realm?.objects(RealmTodo.self)
            .filter({ $0.identifier == selectedTodo.identifier })
            .first
        
        if item != nil {
            try? realm?.write({
                item?.todoListItemStatus = selectedTodo.todoListItemStatus.displayName
                item?.title = selectedTodo.title
                item?.body = selectedTodo.description
                item?.date = selectedTodo.date
                item?.identifier = selectedTodo.identifier
            })
        }
        
        var todoArray = self.todoListBehaviorRelay.value
        if let index = todoArray.firstIndex(where: { $0.identifier == selectedTodo.identifier }) {
            todoArray[index] = selectedTodo
        }

        self.todoListBehaviorRelay.accept(todoArray)
    }
    
    func delete(todoID: UUID) {
        let realm = try? Realm()
        guard let item = realm?.objects(RealmTodo.self).filter({ $0.identifier == todoID }).first else {
            return
        }
        
        try? realm?.write({
            realm?.delete(item)
        })
        
        let items = self.todoListBehaviorRelay.value.filter { $0.identifier != todoID }
        self.todoListBehaviorRelay.accept(items)
    }
}
