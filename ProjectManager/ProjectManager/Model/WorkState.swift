//
//  WorkState.swift
//  ProjectManager
//
//  Created by Judy on 2022/09/15.
//

enum WorkState: Int, CaseIterable {
    case todo = 0
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
