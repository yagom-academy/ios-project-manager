//
//  Task.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

struct Task {
    let id: String
    var title: String
    var content: String
    var deadLine: Double
    var state: State
    var isExpired: Bool
    
    enum State: Int {
        case toDo
        case doing
        case done
    }
}
