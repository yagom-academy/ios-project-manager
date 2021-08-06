//
//  TaskViewModelTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class TaskViewModelTests: XCTestCase {

    var sutTaskViewModel: TaskViewModel!
    var mockCoreDataStack: CoreDataStackProtocol!
    var stubNetworkRepository: StubNetworkRepository!

    var addedIndex: Int!
    var isChanged: Bool!
    var insertedStateAndIndex: (state: Task.State, index: Int)!
    var removedStateAndIndex: (state: Task.State, index: Int)!

    // TODO: SpyTaskRepository 이니셜라이저 변경
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCoreDataStack = MockCoreDataStack()
        stubNetworkRepository = StubNetworkRepository()
        sutTaskViewModel = TaskViewModel(networkRepository: stubNetworkRepository, coreDataStack: mockCoreDataStack)

        sutTaskViewModel.added = { (index) in
            self.addedIndex = index
        }
        sutTaskViewModel.changed = {
            self.isChanged = true
        }
        sutTaskViewModel.inserted = { (state, index) in
            self.insertedStateAndIndex = (state, index)
        }
        sutTaskViewModel.removed = { (state, index) in
            self.removedStateAndIndex = (state, index)
        }

        isChanged = false
    }

    override func tearDownWithError() throws {
        sutTaskViewModel = nil
        mockCoreDataStack = nil
        stubNetworkRepository = nil
        addedIndex = nil
        isChanged = nil
        insertedStateAndIndex = nil
        removedStateAndIndex = nil
        try super.tearDownWithError()
    }

    func test_task를_todo에_추가한다() throws {
        let expectedResponseTask = TestAsset.dummyTodoResponseTask
        stubNetworkRepository.expectedResponseTask = expectedResponseTask
        let expectedTask = Task(context: mockCoreDataStack.context, responseTask: expectedResponseTask)

        sutTaskViewModel.add(expectedTask)

        let taskFromTaskList = sutTaskViewModel.taskList[.todo].first
        XCTAssertEqual(taskFromTaskList, expectedTask)
        XCTAssertEqual(taskFromTaskList?.id, expectedTask.id)
        XCTAssertEqual(taskFromTaskList?.title, expectedTask.title)
        XCTAssertEqual(taskFromTaskList?.body, expectedTask.body)
        XCTAssertEqual(taskFromTaskList?.dueDate, expectedTask.dueDate)
        XCTAssertEqual(taskFromTaskList?.state, expectedTask.state)
        XCTAssertEqual(addedIndex, .zero)
        XCTAssertTrue(isChanged)
        XCTAssertTrue(stubNetworkRepository.isPostCalled)
    }
    
    func test_네트워크가연결되지않았을때_remove에삭제할task의state와index를전달하면_task를softDelete할수있다() {
        let expectedResponseTask = TestAsset.dummyTodoResponseTask
        let expectedResponseStatusCode = 400
        let expectedPMError: PMError = .failureResponse(expectedResponseStatusCode)
        stubNetworkRepository.expectedResponseTask = expectedResponseTask
        stubNetworkRepository.expectedResponseStatusCode = expectedResponseStatusCode
        stubNetworkRepository.expectedPMError = expectedPMError
        
        let expectedTask = Task(context: mockCoreDataStack.context, responseTask: expectedResponseTask)
        sutTaskViewModel.add(expectedTask)

        let removedTitle = sutTaskViewModel.remove(state: .todo, at: .zero)

        let removed = mockCoreDataStack.context.object(with: expectedTask.objectID) as? Task
        XCTAssertEqual(removedTitle, expectedTask.title)
        XCTAssertTrue(sutTaskViewModel.taskList[.todo].isEmpty)
        XCTAssertEqual(removed, expectedTask)
        XCTAssertEqual(removed?.id, expectedTask.id)
        XCTAssertEqual(removed?.title, expectedTask.title)
        XCTAssertEqual(removed?.body, expectedTask.body)
        XCTAssertEqual(removed?.dueDate, expectedTask.dueDate)
        XCTAssertEqual(removed?.state, expectedTask.state)
        XCTAssertTrue(removed!.isRemoved)
        XCTAssertEqual(removedStateAndIndex.state, .todo)
        XCTAssertEqual(removedStateAndIndex.index, .zero)
        XCTAssertTrue(stubNetworkRepository.isDeleteCalled)
    }

    func test_네트워크가연결되었을때_remove에삭제할task의state와index를전달하면_task를delete할수있다() {
        let expectedResponseTask = TestAsset.dummyTodoResponseTask
        let expectedResponseStatusCode = 204
        stubNetworkRepository.expectedResponseTask = expectedResponseTask
        stubNetworkRepository.expectedResponseStatusCode = expectedResponseStatusCode
        
        let expectedTask = Task(context: mockCoreDataStack.context, responseTask: expectedResponseTask)
        sutTaskViewModel.add(expectedTask)

        let removedTitle = sutTaskViewModel.remove(state: .todo, at: .zero)

        let removed = mockCoreDataStack.context.object(with: expectedTask.objectID)
        XCTAssertEqual(removedTitle, TestAsset.dummyTodoResponseTask.title)
        XCTAssertTrue(sutTaskViewModel.taskList[.todo].isEmpty)
        XCTAssertTrue(removed.isFault)
        XCTAssertEqual(removedStateAndIndex.state, .todo)
        XCTAssertEqual(removedStateAndIndex.index, .zero)
        XCTAssertTrue(stubNetworkRepository.isDeleteCalled)
    }
}
