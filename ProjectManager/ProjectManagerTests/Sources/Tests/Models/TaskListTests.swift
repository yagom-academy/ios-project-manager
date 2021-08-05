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
    var mockTaskCoreDataStack: CoreDataStack!
    var tasks: [Task] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTaskCoreDataStack = MockTaskCoreDataStack()
        let context = mockTaskCoreDataStack.context

        tasks.append(Task(context: context))
        tasks[0].id = UUID()
        tasks[0].title = "A"
        tasks[0].dueDate = Date()
        tasks[0].taskState = .todo

        tasks.append(Task(context: context))
        tasks[1].id = UUID()
        tasks[1].title = "B"
        tasks[1].dueDate = Date()
        tasks[1].taskState = .doing

        tasks.append(Task(context: context))
        tasks[2].id = UUID()
        tasks[2].title = "C"
        tasks[2].dueDate = Date()
        tasks[2].taskState = .done

        try context.save()

        sutTaskList = TaskList(todos: [tasks[0]], doings: [tasks[1]], dones: [tasks[2]])
    }

    override func tearDownWithError() throws {
        sutTaskList = nil
        mockTaskCoreDataStack = nil
        tasks = []
        try super.tearDownWithError()
    }

    func test_ids로연산하면_모든상태의Task의id들의Set을반환한다() {
        let expected: Set<UUID> = Set(tasks.map { $0.id })

        XCTAssertEqual(sutTaskList.ids, expected)
    }

    func test_state로접근하면_해당state의Task의배열을반환한다() {
        let expected: [Task] = [tasks[0]]

        XCTAssertEqual(sutTaskList[.todo], expected)
    }

    func test_state로접근하여_수정하면_해당state의Task에반영된다() {
        let expectedTasks: [Task] = tasks

        let movingTasks = [sutTaskList[.doing].removeFirst(), sutTaskList[.done].removeFirst()]
        movingTasks.forEach { $0.taskState = .todo }

        sutTaskList[.todo].append(contentsOf: movingTasks)

        XCTAssertEqual(sutTaskList[.todo], expectedTasks)
    }
}
