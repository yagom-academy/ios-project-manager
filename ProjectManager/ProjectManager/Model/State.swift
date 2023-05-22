//
//  State.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/21.
//

enum State: CaseIterable {
    case Todo
    case Doing
    case Done
    
    var title: String {
        switch self {
        case .Todo:
            return "TODO"
        case .Doing:
            return "DOING"
        case .Done:
            return "DONE"
        }
    }
}
