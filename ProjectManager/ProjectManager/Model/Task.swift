//
//  Task.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/17.
//

import Foundation

struct Task: Hashable {
    let id = UUID().uuidString
    let title: String
    let description: String
    let date: Date
    var state = TaskState.todo
}

