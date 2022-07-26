//
//  TodoHistoryRepositoryTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import XCTest

@testable import ProjectManager

class TodoHistoryRepositoryTests: XCTestCase {
    var mockHistoryStorage: MockHistoryStorage!
    var repository: TodoHistoryRepository!
    var dummyTodoHistory: TodoHistory!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockHistoryStorage = MockHistoryStorage()
        repository = TodoHistoryRepository(storage: mockHistoryStorage)
        dummyTodoHistory = TodoHistory(title: "", createdAt: Date())
    }
    
    func test_create를호출할때_createCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.create(dummyTodoHistory)
        
        // then
        XCTAssertEqual(expected, mockHistoryStorage.createCallCount)
    }
    
    func test_read를호출할때_readCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.todoHistoriesPublisher()
        
        // then
        XCTAssertEqual(expected, mockHistoryStorage.readCallCount)
    }
    
    func test_delete를호출할때_deleteCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.delete(item: dummyTodoHistory)
        
        // then
        XCTAssertEqual(expected, mockHistoryStorage.deleteCallCount)
    }
}
