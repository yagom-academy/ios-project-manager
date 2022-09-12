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

    convenience init(title: String, description: String, deadline: String) {
        self.init()
        self.taskTitle = title
        self.taskDescription = description
        self.taskDeadline = deadline
    }
}
