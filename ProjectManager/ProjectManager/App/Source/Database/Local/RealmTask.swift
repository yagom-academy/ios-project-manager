//
//  RealmTask.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/26.
//

import Foundation
import RealmSwift

final class RealmTask: Object {
    @Persisted var id: UUID
    @Persisted var state: TaskState
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var deadline: Date
    
    init(id: UUID, state: TaskState, title: String, body: String, deadline: Date) {
        self.id = id
        self.state = state
        self.title = title
        self.body = body
        self.deadline = deadline
    }
    
    convenience init(task: MyTask) {
        self.init(id: task.id,
                  state: task.state,
                  title: task.title,
                  body: task.body,
                  deadline: task.deadline)
    }
}
