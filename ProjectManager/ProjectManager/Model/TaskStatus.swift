//
//  TaskStatus.swift
//  ProjectManager
//
//  Created by 천수현 on 2021/07/21.
//

import Foundation

enum TaskStatus {
    case TODO
    case DOING
    case DONE

    var name: String {
        switch self {
        case .TODO:
            return "TODO"
        case .DOING:
            return "DOING"
        case .DONE:
            return "DONE"
        }
    }
}
