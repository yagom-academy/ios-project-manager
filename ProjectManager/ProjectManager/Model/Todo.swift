//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo: Hashable {
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
    let title: String
    let detail: String
    let endDate: TimeInterval
    let completionState: Completion
}
