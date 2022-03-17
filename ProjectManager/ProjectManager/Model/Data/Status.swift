//
//  Status.swift
//  ProjectManager
//
//  Created by 1 on 2022/03/06.
//

import Foundation

enum Status: String {
    
    case todo
    case doing
    case done
}

// MARK: - CustomStringConvertible
extension Status: CustomStringConvertible {
    
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
