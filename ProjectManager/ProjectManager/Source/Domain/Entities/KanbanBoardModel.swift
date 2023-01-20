//
//  KanbanBoardModel.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/20.
//

struct KanbanBoardModel: Hashable {
    let state: Task.State
    let tasks: [Task]
}
