//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay
import RxSwift
import Network

protocol MainViewModelEvent {
    func cellItemDeleted(at indexPath: IndexPath, taskType: TaskType)
}

protocol MainViewModelState {
    var todos: BehaviorRelay<[Task]> { get }
    var doings: BehaviorRelay<[Task]> { get }
    var dones: BehaviorRelay<[Task]> { get }
    var network: BehaviorRelay<Bool> { get }
}

final class MainViewModel: MainViewModelEvent, MainViewModelState, ErrorObservable {
    
    var todos: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var doings: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var dones: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var network: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var error: PublishRelay<DatabaseError> = .init()

    private lazy var synchronizeManager = SynchronizeManager(realmManager: realmManager)
    private let realmManager = RealmManager()
    private let monitor = NWPathMonitor()
    
    func cellItemDeleted(at indexPath: IndexPath, taskType: TaskType) {
        let task: Task
        switch taskType {
        case .todo:
            task = todos.value[indexPath.row]
        case .doing:
            task = doings.value[indexPath.row]
        case .done:
            task = dones.value[indexPath.row]
        }
        deleteData(task: task)
    }
    
    func viewDidLoad() {
        startMonitoring()
        fetchData()
    }
    
    func startMonitoring() {
        let monitoringQueue = DispatchQueue(label: "network", attributes: .concurrent)
        monitor.start(queue: monitoringQueue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.network.accept(true)
            } else {
                self?.network.accept(false)
            }
        }
    }
    
    func syncronize() {
        synchronizeManager.synchronizeDatabase { [weak self] result in
            switch result {
            case .success:
                self?.fetchData()
                return
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
    
    private func deleteData(task: Task) {
        let title = task.title
        let type = task.taskType
                
        do {
            try realmManager.delete(task: task)
            sendNotificationForHistory(title, from: type)
            
        } catch {
            self.error.accept(DatabaseError.deleteError)
        }
        
        switch type {
        case .todo:
            fetchToDo()
        case .doing:
            fetchDoing()
        case .done:
            fetchDone()
        }
    }
    
    private func sendNotificationForHistory(_ title: String, from type: TaskType) {
        let content = "Removed '\(title)' from \(type)"
        let time = Date().timeIntervalSince1970
        let history: [String: Any] = ["content": content, "time": time]
        NotificationCenter.default.post(name: NSNotification.Name("History"), object: nil, userInfo: history)
    }
        
    private func fetchToDo() {
        let todos = realmManager.fetchTasks(type: .todo)
        self.todos.accept(todos)
    }
    
    private func fetchDoing() {
        let doings = realmManager.fetchTasks(type: .doing)
        self.doings.accept(doings)
    }
    
    private func fetchDone() {
        let dones = realmManager.fetchTasks(type: .done)
        self.dones.accept(dones)
    }
}
