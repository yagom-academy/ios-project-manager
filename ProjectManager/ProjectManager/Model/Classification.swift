//
//  Classification.swift
//  ProjectManager
//
//  Created by 기원우 on 2021/08/05.
//

import Foundation

enum Classification {
    case todo
    case doing
    case done

    var name: String {
        switch self {
        case .todo:
            return "todo"
        case .doing:
            return "doing"
        case .done:
            return "done"
        }
    }
}
