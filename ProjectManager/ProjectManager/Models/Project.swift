//
//  Project.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import Foundation

struct Project: Hashable {
    enum Status {
        case todo
        case doing
        case done
    }

    let id: UUID
    var status: Status
    var title: String
    var description: String
    var dueDate: Date

    init(id: UUID = UUID(),
         status: Status = .todo,
         title: String = "",
         description: String = " ",
         dueDate: Date = Date()) {
        self.id = id
        self.status = status
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}
