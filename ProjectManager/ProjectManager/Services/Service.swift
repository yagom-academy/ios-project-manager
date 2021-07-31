//
//  Service.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/31.
//

import Foundation

struct Service {
    private let networkManager = NetworkManager()
    
    func getTask(status: State, completion: @escaping ([Task]) -> ()) {
        networkManager.get { tasks in
            let filteredTaskList = filterTaskData(status: status, taskList: tasks)
            completion(filteredTaskList)
        }
    }
    
    func postTask(task: Task, completion: @escaping (Task) -> ()) {
        networkManager.post(task: task) { task in
            
        }
    }
    
    func patchTask(task: Task, completion: @escaping () -> ()) {
        networkManager.patch(task: task) { task in
        }
    }
    
    func deleteTask(id: String, completion: @escaping () -> ()) {
        networkManager.delete(id: id) {
        }
    }
    
    func filterTaskData(status: State, taskList: [Task]) -> [Task]{
        switch status {
        case .todo:
            return taskList.filter{$0.status == State.todo.rawValue}
        case .doing:
            return taskList.filter{$0.status == State.doing.rawValue}
        case .done:
            return taskList.filter{$0.status == State.done.rawValue}
        }
    }
}
