//
//  TaskState.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/17.
//

enum TaskState {
    case todo
    case doing
    case done
    
    var titleText: String {
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
