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

    func test_state와index를통해_해당task를반환한다() throws {
        let expectedTask = Task(context: mockCoreDataStack.context,
                                responseTask: TestAsset.dummyTodoResponseTask)

        stubNetworkRepository.expectedResponseTask = TestAsset.dummyTodoResponseTask
        sutTaskViewModel.add(expectedTask)

        XCTAssertEqual(sutTaskViewModel.task(from: .todo, at: 0), expectedTask)
    }

    func test_존재하지않는index로_task를호출할때_nil을반환한다() throws {
        XCTAssertNil(sutTaskViewModel.task(from: .todo, at: 0))
    }

    func test_같은state내의move시에_이전index에서지우고_새index에삽입한다() throws {
        let tasks: [Task] = TestAsset.dummyThreeTodoResponseTasks.map { (dummyTodoResponseTask) in
            Task(context: mockCoreDataStack.context, responseTask: dummyTodoResponseTask)
        }
        let expectedTasks: [Task] = [tasks[2], tasks[0], tasks[1]]

        for index in (0..<tasks.count) {
            stubNetworkRepository.expectedResponseTask = TestAsset.dummyThreeTodoResponseTasks[index]
            sutTaskViewModel.add(tasks[index])
        }

        sutTaskViewModel.move(in: .todo, from: 2, to: 0)

        XCTAssertEqual(sutTaskViewModel.taskList[.todo], expectedTasks)
    }

    func test_존재하지않는index들로_같은state내의move시에_동작하지않는다() throws {
        let expectedTasks: [Task] = TestAsset.dummyThreeTodoResponseTasks.map { (dummyTodoResponseTask) in
            Task(context: mockCoreDataStack.context, responseTask: dummyTodoResponseTask)
        }

        for index in (0..<expectedTasks.count) {
            stubNetworkRepository.expectedResponseTask = TestAsset.dummyThreeTodoResponseTasks[index]
            sutTaskViewModel.add(expectedTasks[index])
        }

        sutTaskViewModel.move(in: .todo, from: 3, to: 0)

        XCTAssertEqual(sutTaskViewModel.taskList[.todo], expectedTasks)
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

    func test_state를통해_count를반환한다() {
        let expectedCount: Int = 1

        let task = Task(context: mockCoreDataStack.context, responseTask: TestAsset.dummyTodoResponseTask)
        stubNetworkRepository.expectedResponseTask = TestAsset.dummyTodoResponseTask
        sutTaskViewModel.add(task)

        XCTAssertEqual(sutTaskViewModel.count(of: .todo), expectedCount)
    }

    func test_network가연결되면_taskList를CoreData에서읽어온다() {
        stubNetworkRepository.expectedResponseTasks = TestAsset.dummyThreeTodoResponseTasks
        sutTaskViewModel.networkDidConnect()

        XCTAssertTrue(isChanged)
    }

    func test_network가끊기면_taskList를CoreData에서읽어온다() {
        sutTaskViewModel.networkDidDisconnect()

        XCTAssertTrue(isChanged)
    }
}
