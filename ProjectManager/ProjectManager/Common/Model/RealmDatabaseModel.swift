//
//  RealmDatabaseModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class RealmDatabaseModel: Object {
    @Persisted var taskTitle: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var taskDeadline: String = ""
    @Persisted var taskState: String = TaskState.todo
    @Persisted var id: UUID = UUID()

    convenience init(title: String, description: String, deadline: String, state: String) {
        self.init()
        self.taskTitle = title
        self.taskDescription = description
        self.taskDeadline = deadline
        self.taskState = state
    }
}
