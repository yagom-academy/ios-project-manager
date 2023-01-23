//
//  Project.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/17.
//

import Foundation

struct Project: Hashable {
    let id: UUID
    var status: ProjectStatus
    var title: String
    var description: String
    var dueDate: Date

    init(id: UUID = UUID(),
         status: ProjectStatus,
         title: String,
         description: String,
         dueDate: Date) {
        self.id = id
        self.status = status
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}

extension Project {
    var isDueDateExpired: Bool {
        return dueDate.isExpired
    }
}
