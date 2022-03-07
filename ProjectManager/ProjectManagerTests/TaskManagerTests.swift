//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by 이차민 on 2022/03/02.
//

import XCTest
@testable import ProjectManager

class TaskManagerTests: XCTestCase {
    var mockTaskMemoryRepository: TaskRepository!
    var taskManager: TaskManager!
    
    override func setUp() {
        mockTaskMemoryRepository = MockTaskMemoryRepository()
        taskManager = TaskManager(taskRepository: mockTaskMemoryRepository)
    }
    
    override func tearDown() {
        mockTaskMemoryRepository = nil
        taskManager = nil
    }
    
    func test_task_만들고_확인하기() {
        let task = Task(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
        taskManager.create(with: task)
        
        let tasks = taskManager.fetchAll()
        XCTAssertEqual(tasks[0], task)
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
        XCTAssertEqual(result[0], changedTask)
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
    
    func test_상태가_다른_task를_3개_만들고_진행중인_0번째_task_가져오기() {
        let taskWaiting = Task(id: UUID(),
                        title: "대기중",
                        description: "본문",
                        deadline: Date(),
                        state: .waiting)
    
        let taskProgress = Task(id: UUID(),
                        title: "진행중",
                        description: "본문",
                        deadline: Date(),
                        state: .progress)
        
        let taskDone = Task(id: UUID(),
                        title: "완료",
                        description: "본문",
                        deadline: Date(),
                        state: .progress)
        
        [taskWaiting, taskProgress, taskDone].forEach {
            taskManager.create(with: $0)
        }
        
        let result = taskManager.fetch(at: 0, with: .progress)
        XCTAssertEqual(result, taskProgress)
    }
}
