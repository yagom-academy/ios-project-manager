//
//  Status.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/11.
//

enum Status: CaseIterable {
    case todo
    case doing
    case done
    
    var text: String {
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
