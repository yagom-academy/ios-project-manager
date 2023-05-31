//
//  MyTask.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

struct MyTask: Hashable, Codable, DataTransferObject {
    let id: UUID
    var state: TaskState
    var title: String
    var body: String
    var deadline: TimeInterval
    
    init(id: UUID = UUID(), state: TaskState, title: String, body: String, deadline: TimeInterval) {
        self.id = id
        self.state = state
        self.title = title
        self.body = body
        self.deadline = deadline
    }
    
    init(_ realmTask: RealmTask) {
        self.id = realmTask.id
        self.state = realmTask.state
        self.title = realmTask.title
        self.body = realmTask.body
        self.deadline = realmTask.deadline
    }
}
