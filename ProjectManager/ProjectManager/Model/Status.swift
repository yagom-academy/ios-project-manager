//
//  ProjectManager - Status.swift
//  Created by Rhode.
//  Copyright © yagom. All rights reserved.
//

enum Status: Int, CaseIterable {
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
