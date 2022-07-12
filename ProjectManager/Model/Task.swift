//
//  Task.swift
//  ProjectManager
//
//  Created by OneTool, marisol on 2022/07/12.
//

import Foundation

struct Task: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var date: Date
    var body: String
    var type: TaskType
}

enum TaskType {
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
