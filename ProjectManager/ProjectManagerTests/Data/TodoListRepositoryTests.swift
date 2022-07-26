//
//  TodoListRepositoryTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import XCTest

@testable import ProjectManager

class TodoListRepositoryTests: XCTestCase {
    var mockRealmStorage: MockRealmStorage!
    var mockFirebaseStorage: MockFirebaseStrorage!
    var repository: TodoListRepository!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockRealmStorage = MockRealmStorage()
        mockFirebaseStorage = MockFirebaseStrorage()
        repository = TodoListRepository(todoLocalStorage: mockRealmStorage, todoRemoteStorage: mockFirebaseStorage, isFirstLogin: false)
    }
    
    func test_create를호출할때_createCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.create(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockRealmStorage.createCallCount)
    }
    
    func test_read를호출할때_readCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.todosPublisher()
        
        // then
        XCTAssertEqual(expected, mockRealmStorage.readCallCount)
    }
    
    func test_update를호출할때_updateCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.update(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockRealmStorage.updateCallCount)
    }
    
    func test_delete를호출할때_deleteCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        repository.delete(item: Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockRealmStorage.deleteCallCount)
    }
    
//    func test_synchronizeDatabase를호출할때_synchronizeDatabaseCallCount가하나늘어난다() {
//        // given
//        let expected = 1
//
//        // when
//        repository.synchronizeDatabase()
//
//        // then
//        XCTAssertEqual(expected, mockFirebaseStorage.backupCallCount)
//        XCTAssertEqual(expected, mockFirebaseStorage.readCallCount)
//    }
}
