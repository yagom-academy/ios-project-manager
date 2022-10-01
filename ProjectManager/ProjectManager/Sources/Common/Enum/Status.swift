//
//  Status.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

enum Status {
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
    
    var color: String {
        switch self {
        case .todo:
            return "customRed"
        case .doing:
            return "customGray"
        case .done:
            return "customGreen"
        }
    }
    
    var image: String {
        switch self {
        case .todo:
            return "circle"
        case .doing:
            return "circle.circle"
        case .done:
            return "circle.inset.filled"
        }
    }
}
