//
//  Task.swift
//  ProjectManager
//
//  Created by 이차민 on 2022/03/01.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let deadline: Date
    let state: TaskState
}
