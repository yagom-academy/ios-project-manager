//
//  Task.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/01.
//

import Foundation

struct Task: Identifiable {
    
    let id: UUID
    var title: String
    var description: String
    var dueDate: Date
    var status: TaskStatus
    
}

extension Task: Equatable { }

extension Task {
    
    init(_ object: RealmTask) {
        self.id = object.id
        self.title = object.title
        self.description = object.taskDescription
        self.dueDate = object.dueDate
        self.status = TaskStatus(rawValue: object.status) ?? .todo
    }
    
    init(_ object: FirebaseTask) {
        self.id = UUID(uuidString: object.id) ?? UUID()
        self.title = object.title
        self.description = object.description
        self.dueDate = Date(timeIntervalSince1970: object.dueDate)
        self.status = TaskStatus(rawValue: object.status) ?? .todo
    }
    
}
