//
//  MockHistoryRepository.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import XCTest
import Foundation
import RxSwift
@testable import ProjectManager

enum HistoryRepositoryAction {
    case read
    case save
}

class MockHistoryRepository: HistoryRepository {
    var errorObserver: Observable<TodoError> = .just(.saveError)
    var actions: [HistoryRepositoryAction] = []
    var target: History?
    
    let storage = BehaviorSubject<[History]>(value: [])
    
    func read() -> BehaviorSubject<[History]> {
        actions.append(.read)
        return storage
    }
    
    func save(to data: History) {
        actions.append(.save)
        target = data
    }
    
    func verify(title: String,
                changes: Changes,
                afterState: State? = nil,
                beforeState: State? = nil,
                actions: [HistoryRepositoryAction],
                actionCount: Int,
                file: StaticString = #file,
                line: UInt = #line) {
        XCTAssertEqual(target?.title, title, file: file, line: line)
        XCTAssertEqual(target?.changes, changes, file: file, line: line)
        XCTAssertEqual(target?.afterState, afterState, file: file, line: line)
        XCTAssertEqual(target?.beforeState, beforeState, file: file, line: line)
        XCTAssertEqual(self.actions, actions, file: file, line: line)
        XCTAssertEqual(self.actions.count, actionCount, file: file, line: line)
    }
}
