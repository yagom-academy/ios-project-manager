//
//  ToDoStatus.swift
//  ProjectManager
//
//  Created by Min Hyun on 2023/09/24.
//

enum ToDoStatus: Int, CaseIterable {
    case todo = 0
    case doing = 1
    case done = 2
    
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
