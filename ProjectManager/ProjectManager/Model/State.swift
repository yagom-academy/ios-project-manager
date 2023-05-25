//
//  State.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/21.
//

enum State: CaseIterable {
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
