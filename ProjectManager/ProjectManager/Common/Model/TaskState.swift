//
//  TaskState.swift
//  ProjectManager
//
//  Created by seohyeon park on 2022/09/17.
//

enum TaskState {
    case todo, doing, done

    var name: String {
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
