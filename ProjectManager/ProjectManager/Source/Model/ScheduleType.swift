//
//  ScheduleType.swift
//  ProjectManager
//
//  Created by songjun, vetto on 2023/05/24.
//

enum ScheduleType {
    case todo
    case doing
    case done
    
    var title: String {
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
