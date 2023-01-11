//
//  Process.swift
//  ProjectManager
//
//  Created by Kyo on 2023/01/11.
//

import Foundation

enum Process {
    case todo
    case doing
    case done
    
    var titleValue: String {
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
