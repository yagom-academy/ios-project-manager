//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

final class DataManager {
    
    let dbManager: DBManagerable
    var todoTasks: [Todo] {
        return self.dbManager.todoTasks
    }
    var doingTasks: [Todo] {
        return self.dbManager.doingTasks
    }
    var doneTasks: [Todo] {
        return self.dbManager.doneTasks
    }
    
    init(dbManager: DBManagerable = TodoDataManager()) {
        self.dbManager = dbManager
    }
    
    func fetch() -> [Todo] {
        self.dbManager.fetch()
    }
    
    func add(title: String, body: String, status: Status) {
        self.dbManager.add(title: title, body: body, status: status)
    }
    
    func delete(id: UUID) {
        self.dbManager.delete(id: id)
    }
    
    func update(id: UUID, title: String, body: String) {
        self.dbManager.update(id: id, title: title, body: body)
    }
    
    func changeStatus(id: UUID, to status: Status) {
        self.dbManager.changeStatus(id: id, to: status)
    }
    
}
