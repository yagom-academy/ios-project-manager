//
//  TaskManageable.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/03.
//

import Foundation

protocol TaskManageable: AnyObject {
    
    func fetchTasks(in status: TaskStatus) -> [Task]
    func validateTask(title: String, body: String) -> Bool
    func createTask(title: String, body: String, dueDate: Date)
    func editTask(target: Task?, title: String, body: String, dueDate: Date) throws
    func changeTaskStatus(target: Task?, to status: TaskStatus) throws
    func deleteTask(indexSet: IndexSet, in status: TaskStatus) throws
}
