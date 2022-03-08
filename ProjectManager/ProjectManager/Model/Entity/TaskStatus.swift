//
//  TaskStatus.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/01.
//

import Foundation

enum TaskStatus: CaseIterable {
    
    case todo
    case doing
    case done
    
}

extension TaskStatus: Identifiable {
    
    var id: UUID { UUID() }
    
}

extension TaskStatus: CustomStringConvertible {
    
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
