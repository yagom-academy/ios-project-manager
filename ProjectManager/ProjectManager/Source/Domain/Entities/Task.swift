//
//  Task.swift
//  ProjectManager
//
//  Created by 이정민 on 2023/01/17.
//

import Foundation

struct Task {
    let id: UUID
    var title: String
    var content: String
    var deadLine: String
    var state: WorkState
    var isExpired: Bool
    
    enum WorkState {
        case toDo
        case doing
        case done
    }
}
