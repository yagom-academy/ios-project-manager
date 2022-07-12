//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Donnie, Grumpy on 2022/07/11.
//

import Foundation
import RxRelay
import RxSwift

protocol MainViewModelInput {
    func cellItemDeleted(at indexPath: IndexPath, taskType: TaskType)
}

protocol MainViewModelOutput {
    var todos: BehaviorRelay<[Task]> { get }
    var doings: BehaviorRelay<[Task]> { get }
    var dones: BehaviorRelay<[Task]> { get }
}

final class MainViewModel: MainViewModelInput, MainViewModelOutput {
    
    var todos: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var doings: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    var dones: BehaviorRelay<[Task]> = BehaviorRelay(value: AppConstants.defaultTaskArrayValue)
    
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
        realmManager.delete(task: task)
        fetchData()
    }
        
    private func fetchToDo() {
        let todos = realmManager.fetch(taskType: .todo)
        self.todos.accept(todos)
    }
    
    private func fetchDoing() {
        let doings = realmManager.fetch(taskType: .doing)
        self.doings.accept(doings)
    }
    
    private func fetchDone() {
        let dones = realmManager.fetch(taskType: .done)
        self.dones.accept(dones)
    }
}
