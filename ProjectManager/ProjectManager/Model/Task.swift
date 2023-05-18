//
//  Task.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

struct Task: Hashable {
    enum State: CaseIterable {
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
    
    let state: State
    let title: String
    let body: String
    let deadline: Date
}
