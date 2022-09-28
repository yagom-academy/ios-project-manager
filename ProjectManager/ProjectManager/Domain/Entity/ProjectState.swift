//
//  ProjectState.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

enum ProjectState: String, Codable, CaseIterable {
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
    
    var actionTitles: (first: String,
                       second: String) {
        switch self {
        case .todo:
            return ("Move To DOING", "Move To DONE")
        case .doing:
            return ("Move To TODO", "Move To DONE")
        case .done:
            return ("Move To TODO", "Move To DOING")
        }
    }
}
