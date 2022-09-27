//
//  CardType.swift
//  ProjectManager
//
//  Created by Derrick kim on 9/8/22.
//

enum CardType: String {
    case todo = "TODO"
    case doing = "DOING"
    case done = "DONE"
    
    var moveToAnotherSection: String {
        switch self {
        case .todo:
            return "MOVE TO TODO"
        case .doing:
            return "MOVE TO DOING"
        case .done:
            return "MOVE TO DONE"
        }
    }
}
