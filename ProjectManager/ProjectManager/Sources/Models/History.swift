//
//  History.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/30.
//

import Foundation

struct History {

    enum Method {
        case added(title: String)
        case removed(title: String, sourceState: Task.State)
        case moved(title: String, sourceState: Task.State, desinationState: Task.State)
    }

    let method: Method
    let date: Date = Date()
}
