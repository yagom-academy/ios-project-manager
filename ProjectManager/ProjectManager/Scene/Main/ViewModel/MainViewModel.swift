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
import UserNotifications

protocol MainViewModelEvent {
    func cellItemDeleted(at indexPath: IndexPath, taskType: TaskType)
}

protocol MainViewModelState {
    var todos: BehaviorRelay<[Task]> { get }
    var doings: BehaviorRelay<[Task]> { get }
    var dones: BehaviorRelay<[Task]> { get }
    var online: BehaviorRelay<Bool> { get }
    var undoable: BehaviorRelay<Bool> { get }
    var redoable: BehaviorRelay<Bool> { get }
}

final class MainViewModel: MainViewModelEvent,
                            MainViewModelState,
                            ErrorObservable,
                            PopNotificationSendable,
                            PushDeleteNotificationSendable {
    
    fileprivate enum Constants {
        static let monitoringQueue: String = "monitor"
    }
    
    var todos: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var doings: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var dones: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var online: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var undoable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var redoable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var error: PublishRelay<DatabaseError> = .init()

    private lazy var synchronizeManager = SynchronizeManager(realmManager: realmManager)
    private let realmManager = RealmManager()
    private let monitor = NWPathMonitor()
    private let undoManager = AppDelegate.undoManager
    private let userNotificationManager = UserNotificationManager()
    
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
    }
    
    private func startMonitoring() {
        let monitoringQueue = DispatchQueue(label: Constants.monitoringQueue, attributes: .concurrent)
        monitor.start(queue: monitoringQueue)
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.online.accept(true)
                self?.syncronize()
            } else {
                self?.online.accept(false)
            }
            DispatchQueue.main.async {
                self?.fetchData()
                self?.createNotifications()
            }
        }
    }
    
    func syncronize() {
        synchronizeManager.synchronizeDatabase { result in
            switch result {
            case .success:
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
    
    private func deleteData(task: Task) {
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        registerDeleteUndoAction(task: capturedTask)
        let title = capturedTask.title
        let type = capturedTask.taskType
        do {
            try realmManager.delete(task: capturedTask)
            sendNotificationForHistory(title, from: type)
            userNotificationManager.removeUserNotification(of: capturedTask)
            undoable.accept(true)
            redoable.accept(false)
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
    
    private func registerDeleteUndoAction(task: Task) {
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            do {
                self?.registerDeleteRedoAction(task: capturedTask)
                try self?.realmManager.create(task: capturedTask)
                self?.userNotificationManager.addUserNotification(of: capturedTask)
                self?.sendNotificationForHistory()
            } catch {
                self?.error.accept(DatabaseError.createError)
            }
        }
    }
    
    private func registerDeleteRedoAction(task: Task) {
        let capturedTask = Task(
            title: task.title,
            body: task.body,
            date: task.date,
            taskType: task.taskType,
            id: task.id
        )
        let title = capturedTask.title
        let type = capturedTask.taskType
        undoManager.registerUndo(withTarget: self) { [weak self] _ in
            do {
                self?.registerDeleteUndoAction(task: capturedTask)
                try self?.realmManager.delete(task: capturedTask)
                self?.userNotificationManager.removeUserNotification(of: capturedTask)
                self?.sendNotificationForHistory(title, from: type)
            } catch {
                self?.error.accept(DatabaseError.createError)
            }
        }
    }
    
    private func createNotifications() {
        setupTaskDeadlineNotification(todos.value)
        setupTaskDeadlineNotification(doings.value)
        removeAllPendingNotifications(dones.value)
    }
    
    private func setupTaskDeadlineNotification(_ tasks: [Task]) {
        removeAllPendingNotifications(tasks)
        tasks.forEach {
            userNotificationManager.addUserNotification(of: $0)
        }
    }
    
    private func removeAllPendingNotifications(_ tasks: [Task]) {
        userNotificationManager.removeUserNotifications(of: tasks)
    }
    
    func undoButtonTapped() {
        undoManager.undo()
        redoable.accept(true)
        if !undoManager.canUndo {
            undoable.accept(false)
        }
        fetchData()
    }
    
    func redoButtonTapped() {
        undoManager.redo()
        if undoManager.canRedo {
            redoable.accept(true)
        } else {
            redoable.accept(false)
        }
        
        if undoManager.canUndo {
            undoable.accept(true)
        }
        fetchData()
    }
}
