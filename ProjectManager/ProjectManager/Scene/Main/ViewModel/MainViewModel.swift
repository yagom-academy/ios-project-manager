//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay
import RxSwift

protocol MainViewModelEvent {
    func cellItemDeleted(at indexPath: IndexPath, taskType: TaskType)
}

protocol MainViewModelState {
    var todos: BehaviorRelay<[Task]> { get }
    var doings: BehaviorRelay<[Task]> { get }
    var dones: BehaviorRelay<[Task]> { get }
}

final class MainViewModel: MainViewModelEvent, MainViewModelState, ErrorObservable {
    
    var todos: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var doings: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var dones: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var error: PublishRelay<DatabaseError> = .init()
    
    private let realmManager = RealmManager()
    
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
        fetchData()
    }
    
    func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
    
    private func deleteData(task: Task) {
        let type = task.taskType
        
        do {
            try realmManager.delete(task: task)
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
