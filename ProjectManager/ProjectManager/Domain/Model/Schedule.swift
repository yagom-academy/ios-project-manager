//
//  Schedule.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation

struct Schedule {
    let id: UUID?
    var title: String
    var body: String
    var dueDate: Date
    var progress: Progress

    init(id: UUID = UUID(), title: String, body: String, dueDate: Date, progress: Progress) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.progress = progress
    }
}

enum Progress: CaseIterable {
    case todo
    case doing
    case done
}
