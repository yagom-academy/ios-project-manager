//
//  ViewModel.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/19.
//

import Foundation

class TaskViewModel {
    let networkManager = NetworkManager()
    private var taskList: [Task] = [Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModel",
                                         taskDeadline: "ToDoViewModel"),
                                    Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModel",
                                         taskDeadline: "ToDoViewModel"),
                                    Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModel",
                                         taskDeadline: "ToDoViewModel"),
                                    Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModel",
                                         taskDeadline: "ToDoViewModel"),
                                    Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModel",
                                         taskDeadline: "ToDoViewModel"),
                                    Task(taskTitle: "ToDoViewModel",
                                         taskDescription: "ToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModelToDoViewModel",
                                         taskDeadline: "ToDoViewModel")]
    
    func referTask(at: IndexPath) -> Task? {
        if taskList.count > at.row {
            return taskList[at.row]
        }
        return nil
    }
    
    func taskListCount() -> Int {
        return taskList.count
    }
    
    func insertTaskIntoTaskList(index: Int, task: Task) {
        taskList.insert(task, at: index)
    }
    
    func deleteTaskFromTaskList(index: Int) {
        taskList.remove(at: index)
    }
    
    func getTask() {
        networkManager.get { taskList in
            self.taskList.append(contentsOf: taskList)
        }
    }
    
    func postTask() {
        networkManager.post() { Task in
            
        }
    }
    
    func patchTask() {
        networkManager.patch() {
        }
    }
    
    func deleteTask() {
        networkManager.delete() {
        }
    }
}
