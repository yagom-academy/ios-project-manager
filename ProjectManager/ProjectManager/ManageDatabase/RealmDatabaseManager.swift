//
//  RealmDatabaseManager.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/19.
//

import Foundation
import RealmSwift

class RealmDatabaseManager {
    private var realm: Realm?
    
    init() {
        self.realm = try? Realm()
    }
    
    func create(todoData: TodoModel) {
        try? realm?.write {
            realm?.add(todoData.convertDatabaseTodo())
        }
    }
    
    func read() -> [TodoModel] {
        var todoListArray: [TodoModel] = []
        realm?.objects(TodoLocalModel.self).forEach {
            todoListArray.append($0.convertTodoModel())
        }
        
        return todoListArray
    }
    
    func update(updateData: TodoModel) -> Bool {
        let checkData = realm?.objects(TodoLocalModel.self).filter({$0.id == updateData.id}).first
        
        if checkData != nil {
            try? realm?.write({
                checkData?.id = updateData.id
                checkData?.category = updateData.category.rawValue
                checkData?.title = updateData.title
                checkData?.body = updateData.body
                checkData?.createdAt = updateData.createdAt
            })
            return true
        }
        return false
    }
    
    func delete(deleteID: UUID) -> Bool {
        guard let checkData = realm?.objects(TodoLocalModel.self).filter({ $0.id == deleteID }).first else {
            return false
        }
        
        try? realm?.write({ realm?.delete(checkData)})
        
        return true
    }
}
