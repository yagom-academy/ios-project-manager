//
//  TaskManager.swift
//  TaskManager
//
//  Created by 우롱차, 파프리 on 05/07/2022.
//

import Foundation

final class TaskManager {
    private let realmManager: RealmManagerable
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func create(task: Task) throws {
        try realmManager.create(task)
    }
    
    func read(id: String) -> Task? {
        let predicate = NSPredicate(format: "id = %@", id)
        return realmManager.read(predicate)
    }
    
    func readAll() -> [Task] {
        return realmManager.readAll()
    }
    
    func update(task: Task, updateHandler: (Task) -> Void) throws {
        try realmManager.update(data: task, updateHandler: updateHandler)
    }
    
    func delete(task: Task) throws {
        try realmManager.delete(task)
    }
    
    func deleteAll() throws {
        try realmManager.deleteAll()
    }
}
