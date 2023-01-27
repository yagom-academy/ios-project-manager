//
//  ProjectState.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

enum ProjectState: Int, CaseIterable, Codable {
    case todo, doing, done
}

extension ProjectState: CustomStringConvertible {
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
}
