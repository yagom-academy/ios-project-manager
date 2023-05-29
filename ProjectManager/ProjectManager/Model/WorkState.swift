//
//  WorkState.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/17.
//

enum WorkState: CaseIterable {
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
    
    var buttonTitle: String {
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
