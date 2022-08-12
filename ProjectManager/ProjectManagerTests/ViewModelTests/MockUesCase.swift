//
//  MockUseCase.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/26.
//

import Foundation
import RxSwift
import RxCocoa
@testable import ProjectManager

enum Action {
    case create
    case delete
    case update
    case firstMove
    case secondMove
}

class MockUseCase: TodoListUseCase {
    var errorObserver: Observable<TodoError> = Observable.just(.saveError)
    
    let todoList: BehaviorSubject<[TodoModel]>
    let historyList: BehaviorSubject<[History]>
    var actions: [Action] = []
    var targetId: UUID?
    
    init() {
        self.todoList = .init(value: [])
        self.historyList = .init(value: [])
    }
    
    func readItems() -> BehaviorSubject<[TodoModel]> {
        return todoList
    }
    
    func readHistoryItems() -> BehaviorSubject<[History]> {
        return historyList
    }
    
    func createItem(to data: TodoModel) {
        actions.append(.create)
        targetId = data.id
    }
    
    func updateItem(to item: TodoModel) {
        actions.append(.update)
        targetId = item.id
    }
    
    func deleteItem(id: UUID) {
        actions.append(.delete)
        targetId = id
    }
    
    func firstMoveState(item: TodoModel) {
        actions.append(.firstMove)
        targetId = item.id
    }
    
    func secondMoveState(item: TodoModel) {
        actions.append(.secondMove)
        targetId = item.id
    }
}

