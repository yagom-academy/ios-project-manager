//
//  ProjectState.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

enum ProjectState: String, Decodable {
    case todo, doing, done
    
    var name: String {
        switch self {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var actionTitles: (first: String, second: String) {
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
