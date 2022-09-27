//
//  RealmDatabaseModel.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/12.
//

import RealmSwift

class RealmDatabaseModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId = ObjectId()
    @Persisted var taskTitle: String = ""
    @Persisted var taskDescription: String = ""
    @Persisted var taskDeadline: String = ""
    @Persisted var taskState: String = TaskState.todo.name
    @Persisted var uuid: UUID = UUID()
    @Persisted var ownerId: String = "633325cf8b9212a3107532b2"

    convenience init(title: String, description: String, deadline: String, state: String) {
        self.init()
        self.taskTitle = title
        self.taskDescription = description
        self.taskDeadline = deadline
        self.taskState = state
    }
}
