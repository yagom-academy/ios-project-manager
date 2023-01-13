//
//  Status.swift
//  ProjectManager
//
//  Created by summercat on 2023/01/12.
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
