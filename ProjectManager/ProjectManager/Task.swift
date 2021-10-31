//
//  Task.swift
//  ProjectManager
//
//  Created by Dasoll Park on 2021/10/27.
//

import Foundation

struct Task {
    
    var title: String
    var description: String
    var date: Date
    let id = UUID()
    var state: State
    
    enum State {
        case todo
        case doing
        case done
    }
}
