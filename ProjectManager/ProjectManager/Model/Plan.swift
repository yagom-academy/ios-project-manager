//
//  Plan.swift
//  ProjectManager
//
//  Created by 이윤주 on 2021/11/15.
//

import Foundation

struct Plan: Identifiable {
    enum State: String, CaseIterable {
        case toDo
        case doing
        case done
        
        var description: String {
            switch self {
            case .toDo:
                return "TODO"
            case .doing:
                return "DOING"
            case .done:
                return "DONE"
            }
        }
    }
    
    var state: State
    var title: String
    var description: String
    var deadline: Date
    var isOverdue: Bool = false
    var id = UUID()
}
