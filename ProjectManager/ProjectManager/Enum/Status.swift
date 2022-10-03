//
//  Status.swift
//  ProjectManager
//
//  Created by bonf on 2022/09/14.
//

enum Status: Int, CaseIterable {
    case todo
    case doing
    case done
    
    var upperCasedString: String {
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
