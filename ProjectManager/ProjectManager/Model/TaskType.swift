//
//  TaskType.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/06.
//

import RealmSwift

enum TaskType: String, PersistableEnum, Encodable {
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
