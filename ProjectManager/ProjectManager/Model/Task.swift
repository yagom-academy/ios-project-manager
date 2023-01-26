//
//  Task.swift
//  ProjectManager
//
//  Created by jin on 1/21/23.
//

import Foundation

struct Task: Hashable {
    let id: UUID
    let title: String
    let description: String
    let date: Date
    var status: TaskStatus
}

enum TaskStatus: String {
    case todo = "TODO"
    case done = "DONE"
    case doing = "DOING"
    
    var movingOption: [(optionTitle: String, moveTo: TaskStatus)] {
        switch self {
        case .todo:
            return  [(optionTitle: Title.moveToDoing, moveTo: .doing),
                     (optionTitle: Title.moveToDone, moveTo: .done)]
        case .doing:
            return [(optionTitle: Title.moveToToDo, moveTo: .todo),
                    (optionTitle: Title.moveToDone, moveTo: .done)]
        case .done:
            return [(optionTitle: Title.moveToToDo, moveTo: .todo),
                    (optionTitle: Title.moveToDoing, moveTo: .doing)]
        }
    }
}

extension TaskStatus {
    
    private enum Title {
        static let moveToToDo = "Move to TODO"
        static let moveToDoing = "Move to DOING"
        static let moveToDone = "Move to DONE"
    }
}
