//
//  DataManager.swift
//  ProjectManager
//
//  Created by 김준건 on 2021/11/05.
//

import Foundation

protocol DataManagerProtocol {
    func addTask(title: String, message: String ,date: Date, status: Status)
    func updateTaskList(task: TLTask?, status: Status, title: String, message: String, date: Date)
    func deleteTask(task: TLTask)
    var fetchTask: [TLTask] { get }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()
    
    private var tasks: [TLTask] = []
    private init() {}
}

extension DataManager: DataManagerProtocol {
    func addTask(title: String, message: String, date: Date, status: Status) {
        let task = TLTask(title: title, message: message, date: date, status: status)
        tasks.insert(task, at: 0)
    }
    
    func updateTaskList(task: TLTask?, status: Status, title: String, message: String, date: Date) {
        tasks.firstIndex { $0.id == task?.id }.flatMap { tasks[$0] = TLTask(title: title, message: message, date: date, status: status) }
    }
    
    var fetchTask: [TLTask] {
        return tasks
    }
    
    func deleteTask(task: TLTask) {
        tasks = tasks.filter{$0.id != task.id}
    }
}

