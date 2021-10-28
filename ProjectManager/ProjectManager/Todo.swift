//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo {
    enum Completion: CaseIterable, CustomStringConvertible {
        case todo
        case doing
        case done
        
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
    
    var title: String
    var detail: String
    var endDate: Date
    var completionState: Completion
}
