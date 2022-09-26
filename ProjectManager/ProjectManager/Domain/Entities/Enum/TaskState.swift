//
//  ProjectState.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

enum TaskState {
    case todo
    case doing
    case done
    
    var header: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var destination: String {
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
