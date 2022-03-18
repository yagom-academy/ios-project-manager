//
//  RealmTask.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/15.
//

import Foundation
import RealmSwift

final class RealmTask: Object {
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var dueDate: Date
    @Persisted var status: Int
    
    override init() {
        super.init()
        self.id = UUID()
        self.title = String()
        self.taskDescription = String()
        self.dueDate = Date()
        self.status = 0
    }
    
    init(id: UUID, title: String, description: String, dueDate: Date, status: Int) {
        super.init()
        self.id = id
        self.title = title
        self.taskDescription = description
        self.dueDate = dueDate
        self.status = status
    }
    
    init(_ object: Task) {
        super.init()
        self.id = object.id
        self.title = object.title
        self.taskDescription = object.description
        self.dueDate = object.dueDate
        self.status = object.status.rawValue
    }
    
}
