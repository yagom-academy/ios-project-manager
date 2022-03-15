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
    
    init(id: UUID, title: String, description: String, dueDate: Date, status: Int) {
        super.init()
        self.id = id
        self.title = title
        self.taskDescription = description
        self.dueDate = dueDate
        self.status = status
    }
    
}
