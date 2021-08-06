//
//  TaskListTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class TaskListTests: XCTestCase {

    var sutTaskList: TaskList!
    var mockCoreDataStack: CoreDataStackProtocol!
    var tasks: [Task] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCoreDataStack = MockCoreDataStack()
        let context = mockCoreDataStack.context
        tasks.append(Task(context: context, title: "A", dueDate: Date(), state: .todo))
        tasks.append(Task(context: context, title: "B", dueDate: Date(), state: .doing))
        tasks.append(Task(context: context, title: "C", body: "안녕", dueDate: Date(), state: .done))
        try context.save()

        sutTaskList = TaskList(todos: [tasks[0]], doings: [tasks[1]], dones: [tasks[2]])
    }

    override func tearDownWithError() throws {
        sutTaskList = nil
        mockCoreDataStack = nil
        tasks = []
        try super.tearDownWithError()
    }

    func test_count는_모든state의개수를반환한다() {
        let expectedCount: Int = 3

        XCTAssertEqual(sutTaskList.count, expectedCount)
    }

    func test_state로접근하면_해당state의Task의배열을반환한다() {
        let expectedTasks: [Task] = [tasks[0]]

        XCTAssertEqual(sutTaskList[.todo], expectedTasks)
    }

    func test_state로접근하여_수정하면_해당state의Task에반영된다() {
        let expectedTasks: [Task] = tasks

        let movingTasks = [sutTaskList[.doing].removeFirst(), sutTaskList[.done].removeFirst()]
        movingTasks.forEach { $0.taskState = .todo }

        sutTaskList[.todo].append(contentsOf: movingTasks)

        XCTAssertEqual(sutTaskList[.todo], expectedTasks)
    }
}
