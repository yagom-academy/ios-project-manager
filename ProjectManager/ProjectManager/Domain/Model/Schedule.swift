//
//  Schedule.swift
//  ProjectManager
//
//  Created by 이승재 on 2022/03/04.
//

import Foundation

struct Schedule {
    let id: UUID
    var title: String
    var body: String
    var dueDate: Date
    var lastUpdated: Date
    var progress: Progress

    init(
        id: UUID = UUID(),
        title: String,
        body: String,
        dueDate: Date,
        progress: Progress,
        lastUpdated: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.body = body
        self.dueDate = dueDate
        self.progress = progress
        self.lastUpdated = lastUpdated
    }
}

enum Progress: String, CustomStringConvertible, CaseIterable {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"

    var description: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
