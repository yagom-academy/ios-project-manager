//
//  Todo.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import Foundation

struct Todo: Identifiable {
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
    
    let id: Int
    var title: String
    var detail: String
    var endDate: TimeInterval
    var completionState: Completion
}
