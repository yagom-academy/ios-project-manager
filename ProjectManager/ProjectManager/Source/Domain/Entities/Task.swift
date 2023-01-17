//
//  Task.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import Foundation

struct Task {
    let id: String
    var title: String
    var content: String
    var deadLine: String
    var state: State
    var isExpired: Bool
    
    enum State: Int {
        case toDo = 1
        case doing
        case done
    }
}
