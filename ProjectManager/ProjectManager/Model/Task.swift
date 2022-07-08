//
//  Task.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import RealmSwift

final class Task: Object {
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var date: Double
    @Persisted var taskType: TaskType
    @Persisted(primaryKey: true) var id: String
    
    convenience init(
        title: String,
        body: String,
        date: Double,
        taskType: TaskType,
        id: String
    ) {
        self.init()
        self.title = title
        self.body = body
        self.date = date
        self.taskType = taskType
        self.id = id
    }
}
