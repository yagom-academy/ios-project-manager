//
//  RealmTask.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/26.
//

import Foundation
import RealmSwift

final class RealmTask: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var state: TaskState
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var deadline: Date
    
    convenience init(task: MyTask) {
        self.init()
        
        self.id = id
        self.state = state
        self.title = title
        self.body = body
        self.deadline = deadline
    }
}
