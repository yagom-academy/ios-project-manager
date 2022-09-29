//
//  ProjectType.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/13.
//

enum ProjectType: CaseIterable {
    case todo
    case doing
    case done
    
    var titleLabel: String {
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
