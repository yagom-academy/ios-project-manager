//
//  TodoModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation

struct TodoMedel {
    let title: String
    let body: String
    let createAt: Date
    var state: State
}

enum State {
    case todo
    case doing
    case done
}
