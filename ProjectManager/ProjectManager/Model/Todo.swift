//
//  Todo.swift
//  ProjectManager
//
//  Created by tae hoon park on 2021/11/01.
//

import Foundation

struct Project: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var date: Date
    var type: ProjectStatus
    var isOutDated: Bool {
        let calendar = Calendar.current
        switch type {
        case .todo, .doing:
            if calendar.compare(date, to: Date(), toGranularity: .day) == .orderedAscending {
                return true
            } else {
                return false
            }
        case .done:
            return false
        }
    }

    init(id: UUID = UUID(),
         title: String,
         description: String,
         date: Date,
         type: ProjectStatus) {
        self.id = id
        self.title = title
        self.description = description
        self.date = date
        self.type = type
    }
}

enum ProjectStatus: CustomStringConvertible, CaseIterable {
    case todo
    case doing
    case done
    
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
