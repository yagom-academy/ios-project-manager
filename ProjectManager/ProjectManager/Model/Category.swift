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
    
    var other: (Category, Category) {
        switch self {
        case .todo:
            return (.doing, .done)
        case .doing:
            return (.todo, .done)
        case .done:
            return (.todo, .doing)
        }
    }
    
    var otherDescription: (String, String) {
        switch self {
        case .todo:
            return ("Move To Doing", "Move To Done")
        case .doing:
            return ("Move To Todo", "Move To Done")
        case .done:
            return ("Move To Todo", "Move To Doing")
        }
    }
}
