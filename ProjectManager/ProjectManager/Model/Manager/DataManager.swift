//
//  DataManager.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

import Foundation

final class DataManager: ObservableObject {
    
    let dbManager: DBManagerable
    var todoData: [Todo] {
        return self.dbManager.todoData
    }

    init(dbManager: DBManagerable = TodoDataManager()) {
        self.dbManager = dbManager
    }
    
    func fetch() -> [Todo] {
        self.dbManager.fetch()
    }
    
    func add(title: String, body: String, date: Date, status: Status) {
        self.dbManager.add(title: title, body: body, date: date, status: status)
    }
    
    func delete(id: UUID) {
        self.dbManager.delete(id: id)
    }
    
    func update(id: UUID, title: String, body: String, date: Date) {
        self.dbManager.update(id: id, title: title, body: body, date: date)
    }
    
    func changeStatus(id: UUID, to status: Status) {
        self.dbManager.changeStatus(id: id, to: status)
    }
    
}
