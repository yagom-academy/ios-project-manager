//
//  TaskListViewModelDelegate.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/26.
//

import Foundation

protocol TaskListViewModelDelegate {
    func createTask(_ task: Task)
    func updateTask(_ task: Task)
    func deleteTask(id: UUID)
    func changeTaskWorkState(id: UUID, with: WorkState)
}
