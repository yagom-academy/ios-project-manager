//
//  WorkState.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

enum WorkState: String, Decodable {
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
}
