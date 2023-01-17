//
//  TaskList.swift
//  ProjectManager
//
//  Created by 서현웅 on 2023/01/13.
//

import Foundation

struct TaskList {
    let tasks: [Task]
}

struct Task: Hashable {
    let uuid = UUID()
    let title: String?
    let description: String?
    let date: Date?
    let status: Status
}
