//
//  ProjectStatus.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/21.
//

enum ProjectStatus {
    case todo
    case doing
    case done

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
