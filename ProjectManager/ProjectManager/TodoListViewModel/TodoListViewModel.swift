//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/23.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay

class TodoListViewModel {
    private var database: DatabaseManager
    let todoData: Driver<[TodoModel]>
    let doingData: Driver<[TodoModel]>
    let doneData: Driver<[TodoModel]>
    
    init(database: DatabaseManager) {
        self.database = database
        
        self.todoData = database.todoListViewBehaviorRelay.map { $0.filter { $0.category == .todo}}
            .map { $0.sorted { $0.createdAt < $1.createdAt }}
            .asDriver(onErrorJustReturn: [])
        self.doingData = database.todoListViewBehaviorRelay.map { $0.filter { $0.category == .doing}}
            .map { $0.sorted { $0.createdAt < $1.createdAt }}
            .asDriver(onErrorJustReturn: [])
        self.doneData = database.todoListViewBehaviorRelay.map { $0.filter { $0.category == .done}}
            .map { $0.sorted { $0.createdAt < $1.createdAt }}
            .asDriver(onErrorJustReturn: [])
    }
}
