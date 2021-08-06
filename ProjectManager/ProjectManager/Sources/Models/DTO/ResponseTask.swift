//
//  ResponseTask.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import Foundation
import CoreData

struct ResponseTask: Codable {

    let id: UUID
    let title: String
    let body: String?
    let dueDate: Int
    let state: Task.State

    init(id: UUID, title: String, body: String? = nil, dueDate: Int, state: Task.State) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.state = state
    }
}
