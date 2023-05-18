//
//  WorkStatus.swift
//  ProjectManager
//
//  Created by Hyejeong Jeong on 2023/05/18.
//

enum WorkStatus: CaseIterable {
    case todo
    case doing
    case done
    
    var title: String {
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
