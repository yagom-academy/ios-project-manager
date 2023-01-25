//
//  Project.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/17.
//

import Foundation

struct Project: Hashable {
    let id: UUID = .init()
    var status: ProjectStatus
    var title: String
    var description: String
    var dueDate: Date

    init(status: ProjectStatus,
         title: String,
         description: String,
         dueDate: Date) {
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
