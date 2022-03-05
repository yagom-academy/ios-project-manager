//
//  TaskManageable.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/03.
//

import Foundation

protocol TaskManageable: AnyObject {
    
    var todoTasks: [Task] { get }
    var doingTasks: [Task] { get }
    var doneTasks: [Task] { get }
    
    func createTask(title: String, body: String, dueDate: Date)
    func modifyTask(target: Task?, title: String, body: String, dueDate: Date) throws
    func changeTaskStatus(target: Task?, to status: TaskStatus) throws
    func deleteTask(target: Task?) throws
}
