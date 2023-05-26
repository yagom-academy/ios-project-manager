//
//  WorkState.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

enum WorkState {
    case todo
    case doing
    case done
    
    var text: String {
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
