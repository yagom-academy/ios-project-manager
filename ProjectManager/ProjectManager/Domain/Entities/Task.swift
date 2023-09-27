//
//  Task.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import Foundation

struct Task: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var content: String
    var date: Date
    var state: TaskState
}

enum TaskState: Int, CaseIterable {
    case todo = 1, doing, done
    
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
