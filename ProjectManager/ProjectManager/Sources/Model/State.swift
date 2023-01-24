//
//  State.swift
//  ProjectManager
//
//  Created by Hamo, Wonbi on 2023/01/18.
//

enum State: CaseIterable {
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
