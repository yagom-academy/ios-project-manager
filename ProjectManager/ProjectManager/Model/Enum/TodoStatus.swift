//
//  TodoStatus.swift
//  ProjectManager
//
//  Created by Finnn on 2022/09/08.
//

enum TodoStatus: Int, CaseIterable {
    case todo = 0
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
