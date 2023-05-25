//
//  ProjectState.swift
//  ProjectManager
//
//  Created by kaki, 릴라 on 2023/05/17.
//

enum ProjectState: String {
    case todo
    case doing
    case done
    
    var popoverItem: (ProjectState, ProjectState) {
        switch self {
        case .todo:
            return (.doing, .done)
        case .doing:
            return (.todo, .done)
        case .done:
            return (.todo, .doing)
        }
    }
    
    var popoverText: String {
        switch self {
        case .todo:
            return "Move to TODO"
        case .doing:
            return "Move to DOING"
        case .done:
            return "Move to DONE"
        }
    }
}
