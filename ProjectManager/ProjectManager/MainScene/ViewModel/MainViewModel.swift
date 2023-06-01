//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by 레옹아범 on 2023/05/23.
//

import Foundation

class MainViewModel {
    private enum HistoryState {
        case create(_ task: Task)
        case move(prevState: TaskState, nowState: TaskState, _ task: Task)
        case delete(_ task: Task)
        
        var text: String {
            switch self {
            case .create(let task):
                return "Added '\(task.title)'"
            case .move(let prevState, let nowState, let task):
                return "Moved '\(task.title)' from \(prevState.titleText) to \(nowState.titleText)"
            case .delete(let task):
                return "Delete '\(task.title)'"
            }
        }
    }
    
    private let networkMonitor = NetworkMonitor()
    private var dbManager: DBManager?
    private var historyManager = HistoryManager()
    private var tasks: [Task] = [] {
        didSet {
            postChangedTasksNoti()
        }
    }
    
    var networkStateHandler: ((Bool) -> Void)?
    
    var historyTasks: [History] {
        return historyManager.sortedHistoryList
    }
    
    deinit {
        networkMonitor.stopMonitoring()
    }
    
    func configure() {
        let errorHandler: (Error) -> Void = { [weak self] error in
            self?.postDatabaseError(with: error)
        }
        
        let localDB = LocalDBManager<TaskObject>(errorHandler: errorHandler)
        
        dbManager = DBManager(basicDB: localDB)
        dbManager?.errorHandler = errorHandler
        
        networkMonitor.checkNetworkState { [weak self] isConnect in
            DispatchQueue.main.async {
                self?.networkStateHandler?(isConnect)
            }
            self?.dbManager?.changeDatabase(isConnect: isConnect)
            self?.fetchTasks()
        }
    }
    
    func deleteTask(_ task: Task) {
        guard let targetIndex = tasks.firstIndex(of: task) else { return }
        
        tasks.remove(at: targetIndex)
        
        dbManager?.delete(object: task)
        addHistory(historyState: .delete(task))
    }
    
    func changeTaskState(by task: Task, _ state: TaskState) {
        guard let targetIndex = tasks.firstIndex(of: task), let prevState = task.state else {
            return
        }
        
        tasks[targetIndex].state = state
        
        dbManager?.update(object: tasks[targetIndex])
        addHistory(historyState: .move(prevState: prevState, nowState: state, task))
    }
    
    func replaceTask(_ task: Task) {
        let firstIndex = tasks.firstIndex { targetTask in
            return targetTask.id == task.id
        }
        
        guard let targetIndex = firstIndex else { return }
        
        tasks[targetIndex] = task
        
        dbManager?.update(object: task)
    }
    
    func appendTask(_ task: Task) {
        tasks.append(task)
        
        dbManager?.create(object: task)
        addHistory(historyState: .create(task))
    }
    
    func filterTasks(by state: TaskState) -> [Task] {
        let tasks = self.tasks.filter { task in
            return task.state == state
        }
        
        return tasks.sorted { $0.date < $1.date }
    }
    
    private func addHistory(historyState: HistoryState) {
        historyManager.addHistory(text: historyState.text, date: Date())
    }
    
    private func fetchTasks() {
        dbManager?.fetch { [weak self] result in
            switch result {
            case .success(let tasks):
                guard let tasks = tasks as? [Task] else { return }
                self?.tasks = tasks
            case .failure(let error):
                self?.postDatabaseError(with: error)
            }
        }
    }
    
    private func postDatabaseError(with error: Error) {
        NotificationCenter.default.post(name: .errorTask, object: nil, userInfo: ["error": error])
    }
    
    private func postChangedTasksNoti() {
        NotificationCenter.default.post(name: .changedTasks, object: nil)
    }
}
