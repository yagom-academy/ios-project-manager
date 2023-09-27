//
//  TableViewTag.swift
//  ProjectManager
//
//  Created by idinaloq on 2023/09/27.
//

enum TableViewTag {
    case todo
    case doing
    case done
    
    var tag: Int {
        switch self {
        case .todo:
            return 1
        case .doing:
            return 2
        case .done:
            return 3
        }
    }
}
