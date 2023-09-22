//
//  Project.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/20.
//

import Foundation

struct Project: Hashable {
    let id: UUID
    var title: String
    var body: String
    var deadline: Date
    
    init(id: UUID = UUID(), title: String, body: String, deadline: Date) {
        self.id = id
        self.title = title
        self.body = body
        self.deadline = deadline
    }
}
