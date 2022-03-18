//
//  TaskMemoryManagerTests.swift
//  TaskMemoryManagerTests
//
//  Created by JeongTaek Han on 2022/03/01.
//

import XCTest
@testable import ProjectManager

final class TaskMemoryManagerTests: XCTestCase {
    
    private var sutTaskManager: TaskManager!

    override func setUpWithError() throws {
        let initialTasks: [Task] = []
        sutTaskManager = TaskMemoryManager(tasks: initialTasks)
    }

    override func tearDownWithError() throws {
        sutTaskManager = nil
    }

    private func test_create_메서드_실행후_todoTasks의_첫번째_요소로_생성된_Task가_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .todo
        )
        
        // when
        try? sutTaskManager.create(newTask)
        guard let result = sutTaskManager.todoTasks.first else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertEqual(newTask, result)
    }
    
    private func test_create_메서드_실행후_doingTasks의_첫번째_요소로_생성된_Task가_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .doing
        )
        
        // when
        try? sutTaskManager.create(newTask)
        guard let result = sutTaskManager.doingTasks.first else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertEqual(newTask, result)
    }
    
    private func test_create_메서드_실행후_doneTasks의_첫번째_요소로_생성된_Task가_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .done
        )
        
        // when
        try? sutTaskManager.create(newTask)
        guard let result = sutTaskManager.doneTasks.first else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertEqual(newTask, result)
    }
    
    private func test_하나의_Task가_주어졌을때_delete_메서드를_실행하면_todoTasks에_빈배열이_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .todo
        )
        
        try? sutTaskManager.create(newTask)
        
        // when
        try? sutTaskManager.delete(newTask)
        let result = sutTaskManager.todoTasks
        
        // then
        XCTAssertEqual(result, [])
    }
    
    private func test_하나의_Task가_주어졌을때_delete_메서드를_실행하면_doingTasks에_빈배열이_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .doing
        )
        
        try? sutTaskManager.create(newTask)
        
        // when
        try? sutTaskManager.delete(newTask)
        let result = sutTaskManager.doingTasks
        
        // then
        XCTAssertEqual(result, [])
    }
    
    private func test_하나의_Task가_주어졌을때_delete_메서드를_실행하면_doneTasks에_빈배열이_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .done
        )
        
        try? sutTaskManager.create(newTask)
        
        // when
        try? sutTaskManager.delete(newTask)
        let result = sutTaskManager.doneTasks
        
        // then
        XCTAssertEqual(result, [])
    }
    
    private func test_하나의_Task가_주어졌을때_update_메서드를_실행하면_todoTasks에_수정된_task가_반환되어야한다() {
        // given
        let newTask = Task(
            id: UUID(),
            title: "Hello",
            description: "World",
            dueDate: Date(),
            status: .todo
        )
        
        let changeTask = Task(
            id: newTask.id,
            title: "World",
            description: "Hello",
            dueDate: Date(),
            status: newTask.status
        )
        
        try? sutTaskManager.create(newTask)
        
        // when
        try? sutTaskManager.update(newTask, to: changeTask)
        guard let result = sutTaskManager.todoTasks.first else {
            XCTFail()
            return
        }
        
        // then
        XCTAssertEqual(result, changeTask)
    }

}
