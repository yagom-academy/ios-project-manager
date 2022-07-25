//
//  TodoCellContent.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/15.
//

import Foundation

struct TodoCellContent {
    let title: String?
    let body: String?
    let deadlineAt: String
    let id: UUID
    let isPast: Bool

    init(entity: TodoModel, isPast: Bool, dateFormatter: DateFormatter) {
        self.title = entity.title
        self.body = entity.body
        self.deadlineAt = entity.deadlineAt.toString(dateFormatter)
        self.id = entity.id
        self.isPast = isPast
    }
}
