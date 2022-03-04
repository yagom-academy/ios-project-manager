//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by 이차민 on 2022/03/02.
//

import XCTest
@testable import ProjectManager

class TaskManagerTests: XCTestCase {
    var repository: TaskRepository!
    var taskManager: TaskManager!
    
    override func setUp() {
        repository = MemoryRepository()
        taskManager = TaskManager(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        taskManager = nil
    }
    
    func test_task_만들고_확인하기() {
        let task = Task(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
        taskManager.create(with: task)
        
        let tasks = repository.fetchAll()
        XCTAssertEqual(tasks[0].title, "제목")
        XCTAssertEqual(tasks[0].description, "본문")
        XCTAssertEqual(tasks[0].state, .waiting)
    }
    
    func test_task_만들고_삭제하기() {
        let task = Task(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
        taskManager.create(with: task)
        
        taskManager.delete(with: task)
        let result = taskManager.fetchAll()
        XCTAssertEqual(result.count, 0)
    }
    
    func test_task_만들고_제목_변경하기() {
        let task = Task(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
        taskManager.create(with: task)

        let changedTask = Task(id: task.id,
                           title: "바뀐제목",
                           description: task.description,
                           deadline: task.deadline,
                           state: task.state)
        taskManager.update(with: changedTask)

        let result = taskManager.fetchAll()
        XCTAssertEqual(result[0].title, "바뀐제목")
    }
    
    func test_task_만들고_상태_변경하기() {
        let task = Task(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
        taskManager.create(with: task)

        taskManager.changeState(of: task, to: .done)

        let result = taskManager.fetchAll()
        XCTAssertEqual(result[0].state, .done)
    }
}
