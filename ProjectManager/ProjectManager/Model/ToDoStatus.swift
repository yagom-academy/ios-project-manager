//
//  ToDoStatus.swift
//  ProjectManager
//
//  Created by Max on 2023/09/24.
//

enum ToDoStatus: CaseIterable {
    case toDo
    case doing
    case done
    
    var name: String {
        switch self {
        case .toDo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
}
