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

class MockUseCase: TodoListUseCase {
    private let todoList: BehaviorSubject<[TodoModel]>
    private let historyList: BehaviorSubject<[History]>
    
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
        todoList.onNext(try! todoList.value() + [data])
        historyList.onNext(try! historyList.value() + [History(changes: .added, title: data.title!)])
    }
    
    func updateItem(to item: TodoModel) {
        var items = try! todoList.value()
        let index = items.firstIndex { $0.id == item.id }!
        items[index] = item
        todoList.onNext(items)
    }
    
    func deleteItem(id: UUID) {
        var items = try! todoList.value()
        let index = items.firstIndex { $0.id == id }!
        let item = items.remove(at: index)
        let historyItem = History(changes: .removed, title: item.title!, beforeState: item.state)
        
        todoList.onNext(items)
        historyList.onNext(try! historyList.value() + [historyItem])
    }
    
    func firstMoveState(item: TodoModel) {
        var item = item
        let hitoryItem: History
        switch item.state {
        case .todo:
            item.state = .doing
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .doing)
        case .doing:
            item.state = .todo
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .todo)
        case .done:
            item.state = .todo
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .todo)
        }
        
        updateItem(to: item)
        historyList.onNext(try! historyList.value() + [hitoryItem])
    }
    
    func secondMoveState(item: TodoModel) {
        var item = item
        let hitoryItem: History
        switch item.state {
        case .todo:
            item.state = .done
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .done)
        case .doing:
            item.state = .done
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .done)
        case .done:
            item.state = .doing
            hitoryItem = .init(changes: .moved, title: item.title!, beforeState: item.state, afterState: .doing)
        }
        
        updateItem(to: item)
        historyList.onNext(try! historyList.value() + [hitoryItem])
    }
    
    var errorObserver: PublishRelay<TodoError> = PublishRelay()
}

