//
//  TaskType.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/04.
//

import Foundation

enum TaskType {
    case todo, doing, done
    
    var store: [Task] {
        switch self {
        case .todo:
            return TaskStore.shared.todoTask
        case .doing:
            return TaskStore.shared.doingTask
        case .done:
            return TaskStore.shared.doneTask
        }
    }
}
