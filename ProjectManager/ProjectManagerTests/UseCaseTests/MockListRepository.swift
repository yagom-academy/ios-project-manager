//
//  MockListRepository.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import XCTest
import Foundation
import RxSwift
@testable import ProjectManager

enum ListRepositoryAction {
    case read
    case create
    case update
    case delete
}

class MockListRepository: TodoListRepository {
    var errorObserver: Observable<TodoError> = .just(.saveError)
    var actions: [ListRepositoryAction] = []
    var target: TodoModel?
    
    let storage = BehaviorSubject<[TodoModel]>(value: [])
    
    func read() -> BehaviorSubject<[TodoModel]> {
        actions.append(.read)
        return storage
    }
    
    func create(to data: TodoModel) {
        actions.append(.create)
        target = data
    }
    
    func update(to data: TodoModel) {
        actions.append(.update)
        target = data
    }
    
    func delete(index: Int) {
        let items = try! storage.value()
        actions.append(.delete)
        target = items[index]
    }
    
    func verify(item: TodoModel,
                actions: [ListRepositoryAction],
                actionCount: Int,
                file: StaticString = #file,
                line: UInt = #line) {
        XCTAssertEqual(target, item, file: file, line: line)
        XCTAssertEqual(self.actions, actions, file: file, line: line)
        XCTAssertEqual(self.actions.count, actionCount, file: file, line: line)
    }
}
