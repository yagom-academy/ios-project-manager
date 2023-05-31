//
//  RealmTask.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/26.
//

import Foundation
import RealmSwift

final class RealmTask: Object, DataAcessObject {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var state: TaskState
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var deadline: TimeInterval
    
    convenience init(_ task: MyTask) {
        self.init()
        
        self.id = task.id
        self.state = task.state
        self.title = task.title
        self.body = task.body
        self.deadline = task.deadline
    }
    
    func updateValue(task: MyTask) {
        self.state = task.state
        self.title = task.title
        self.body = task.body
        self.deadline = task.deadline
    }
}
