//
//  Service.swift
//  ProjectManager
//
//  Created by 최정민 on 2021/07/31.
//

import Foundation

struct Service {
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreData()
    
    func getTask(status: State, completion: @escaping ([Task]) -> ()) {
        networkManager.get { tasks in
            guard let diskCacheTaskDataList = coreDataManager.getTaskList(),
                  let disCacheTaskList = convertTaskDataListToTaskList(taskDataList: diskCacheTaskDataList) else {
                return
            }
            guard let tasks = tasks else {
                // 서버와 연결이 끊긴 경우이므로 코어데이터에 있는 데이터를 넘겨준다.
                let filteredTaskList = filterTaskData(status: status, taskList: disCacheTaskList)
                completion(filteredTaskList)
                return
            }
            let filteredTaskList = filterTaskData(status: status, taskList: tasks)
            completion(filteredTaskList)
        }
    }
    
    func postTask(task: Task, completion: @escaping (Task) -> ()) {
        coreDataManager.createNewTask(task: task)
        networkManager.post(task: task) { task in
            guard let _ = task else {
                // 서버와 연결이 끊긴 경우이므로 버퍼에 저장한다.
                return
            }
        }
    }
    
    func patchTask(task: Task, completion: @escaping () -> ()) {
        coreDataManager.patchData(task: task)
        networkManager.patch(task: task) { task in
            guard let _ = task else {
                // 서버와 연결이 끊긴 경우이므로 버퍼에 저장한다.
                return
            }
        }
    }
    
    func deleteTask(id: String, completion: @escaping () -> ()) {
        coreDataManager.deleteTask(id: id)
        networkManager.delete(id: id) { networkStatus in
            guard networkStatus else {
                // 서버와 연결이 끊긴 경우이므로 버퍼에 저장한다.
                return
            }
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
    
    func convertTaskDataToTask(taskData: TaskData) -> Task? {
        guard let title = taskData.title,
              let detail = taskData.detail,
              let status = taskData.status,
              let id = taskData.id else {
            return nil
        }
        return Task(title: title, detail: detail, deadline: taskData.deadline, status: status, id: id)
    }
    
    func convertTaskDataListToTaskList(taskDataList: [TaskData]) -> [Task]? {
        var taskList: [Task] = []
        for taskData in taskDataList {
            guard let taskData = convertTaskDataToTask(taskData: taskData) else {
                return nil
            }
            taskList.append(taskData)
        }
        return taskList
    }
}
