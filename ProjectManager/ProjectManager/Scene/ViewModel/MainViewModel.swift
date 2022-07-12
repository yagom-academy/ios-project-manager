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
    func plusButtonTapped()
}

protocol MainViewModelOutput {
    var todos: BehaviorRelay<[Task]> { get }
    var doings: BehaviorRelay<[Task]> { get }
    var dones: BehaviorRelay<[Task]> { get }
    var showNewFormSheetView: PublishRelay<Void> { get }
}

final class MainViewModel: MainViewModelInput, MainViewModelOutput {
    
    var todos: BehaviorRelay<[Task]> = BehaviorRelay(value: [])
    var doings: BehaviorRelay<[Task]> = BehaviorRelay(value: [])
    var dones: BehaviorRelay<[Task]> = BehaviorRelay(value: [])
    var showNewFormSheetView: PublishRelay<Void> = .init()
    
    private let realmManager = RealmManager()
    
    func plusButtonTapped() {
        showNewFormSheetView.accept(())
    }
    
    func viewDidLoad() {
        fetchData()
    }
    
    func fetchData() {
        fetchToDo()
        fetchDoing()
        fetchDone()
    }
    
    func deleteCell(task: Task) {
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
