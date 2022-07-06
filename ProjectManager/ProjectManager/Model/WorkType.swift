//
//  WorkType.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import Foundation

enum WorkType {
    case todo
    case doing
    case done
    
    var value: String {
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
