//
//  Category.swift
//  ProjectManager
//
//  Created by leewonseok on 2023/01/12.
//

import Foundation

enum Category {
    case todo
    case doing
    case done
    
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
