//
//  ProjectState.swift
//  ProjectManager
//
//  Created by junho lee on 2023/01/13.
//

import Foundation

enum ProjectState: Int, CaseIterable, Codable {
    case todo, doing, done
}

extension ProjectState: CustomStringConvertible {
    var description: String {
        switch self {
        case .todo:
            return NSLocalizedString("TODO", comment: "ProjectState TODO description")
        case .doing:
            return NSLocalizedString("DOING", comment: "ProjectState DOING description")
        case .done:
            return NSLocalizedString("DONE", comment: "ProjectState DONE description")
        }
    }
}
