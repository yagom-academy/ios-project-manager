//
//  Status.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

enum Status {
    case todo
    case doing
    case done
    
    var description: String {
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
