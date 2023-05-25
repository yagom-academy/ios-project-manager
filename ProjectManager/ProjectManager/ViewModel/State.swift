//
//  State.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/24.
//

enum State: CustomStringConvertible {
    case todo, doing, done
    
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
