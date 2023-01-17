//
//  Project.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import Foundation

struct Project {
    enum Status {
        case todo
        case doing
        case done
    }

    let id: UUID
    let status: Status
    let title: String
    let description: String
    let dueDate: Date

    init(id: UUID = UUID(),
         status: Status = .todo,
         title: String = "제목 없음",
         description: String = "",
         dueDate: Date = Date()) {
        self.id = id
        self.status = status
        self.title = title
        self.description = description
        self.dueDate = dueDate
    }
}
