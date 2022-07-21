//
//  TodoHistoryUseCaseTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import XCTest

@testable import ProjectManager

class TodoHistoryUseCaseTests: XCTestCase {
    var mockTodoHistoryRepository: MockTodoHistoryRepository!
    var useCase: TodoHistoryUseCase!
    var dummyTodoHistory: TodoHistory!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTodoHistoryRepository = MockTodoHistoryRepository()
        useCase = TodoHistoryUseCase(repository: mockTodoHistoryRepository)
        dummyTodoHistory = TodoHistory(title: "", createdAt: Date())
    }
    
    func test_create를호출할때_createCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.create(dummyTodoHistory)
        
        // then
        XCTAssertEqual(expected, mockTodoHistoryRepository.createCallCount)
    }
    
    func test_read를호출할때_readCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.read()
        
        // then
        XCTAssertEqual(expected, mockTodoHistoryRepository.readCallCount)
    }
    
    func test_delete를호출할때_deleteCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.delete(item: dummyTodoHistory)
        
        // then
        XCTAssertEqual(expected, mockTodoHistoryRepository.deleteCallCount)
    }
}
