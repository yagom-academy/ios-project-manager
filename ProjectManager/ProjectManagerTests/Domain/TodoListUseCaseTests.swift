//
//  TodoListUseCaseTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import XCTest

@testable import ProjectManager

class TodoListUseCaseTests: XCTestCase {
    var mockTodoListRepository: MockTodoListRepository!
    var useCase: TodoListUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTodoListRepository = MockTodoListRepository()
        useCase = TodoListUseCase(repository: mockTodoListRepository)
    }
    
    func test_create를호출할때_createCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.create(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoListRepository.createCallCount)
    }
    
    func test_read를호출할때_readCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.read()
        
        // then
        XCTAssertEqual(expected, mockTodoListRepository.readCallCount)
    }
    
    func test_update를호출할때_updateCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.update(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoListRepository.updateCallCount)
    }
    
    func test_delete를호출할때_deleteCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.delete(item: Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoListRepository.deleteCallCount)
    }
    
    func test_synchronizeDatabase를호출할때_synchronizeDatabaseCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        useCase.synchronizeDatabase()
        
        // then
        XCTAssertEqual(expected, mockTodoListRepository.synchronizeDatabaseCallCount)
    }
}
