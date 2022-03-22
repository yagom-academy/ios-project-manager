//
//  TaskListUseCaseTests.swift
//  TaskListUseCaseTests
//
//  Created by 이차민 on 2022/03/02.
//

import XCTest
@testable import ProjectManager

class TaskListUseCaseTests: XCTestCase {
    var mockTaskMemoryRepository: MockTaskMemoryRepository!
    var taskListUseCase: TaskListUseCase!
    
    override func setUp() {
        let mockTasks = [
            Task(id: UUID(), title: "대기중", description: "대기중_본문", deadline: Date(), state: .waiting),
            Task(id: UUID(), title: "진행중", description: "진행중_본문", deadline: Date(), state: .progress),
            Task(id: UUID(), title: "완료", description: "완료_본문", deadline: Date(), state: .done),
        ]
        mockTaskMemoryRepository = MockTaskMemoryRepository(mockTasks: mockTasks)
        taskListUseCase = DefaultTaskListUseCase(taskRepository: mockTaskMemoryRepository)
    }
    
    override func tearDown() {
        mockTaskMemoryRepository = nil
        taskListUseCase = nil
    }
    
    func test_task_만들고_확인하기() {
        let date = Date()
        let task = Task(title: "새제목", description: "새내용", deadline: date)
        taskListUseCase.create(with: task)
        
        let cretedTask = mockTaskMemoryRepository.createdTask[0]
        XCTAssertEqual(cretedTask.title, "새제목")
        XCTAssertEqual(cretedTask.description, "새내용")
        XCTAssertEqual(cretedTask.deadline, date)
    }
    
    func test_특정_위치의_task_삭제하기() {
        taskListUseCase.delete(at: 0, from: .waiting)
        let deletedTask = mockTaskMemoryRepository.deletedTask
        XCTAssertEqual(deletedTask.count, 1)
    }
    
    func test_준비중인_첫_번째_task_제목_변경하기() {
        let task = Task(title: "바뀐제목", description: "바뀐내용", deadline: Date())
        taskListUseCase.update(at: 0, with: task)

        let updatedTask = mockTaskMemoryRepository.updatedTask[0]
        XCTAssertEqual(updatedTask.title, "바뀐제목")
    }
    
    func test_task_상태_변경하기() {
        taskListUseCase.changeState(at: 0, from: .waiting, to: .done)

        let updatedTask = mockTaskMemoryRepository.updatedTask[0]
        XCTAssertEqual(updatedTask.state, .done)
    }
    
    func test_진행중인_0번째_task_가져오기() {
        let fetchedTask = taskListUseCase.fetch(at: 0, from: .progress)
        XCTAssertEqual(fetchedTask?.state, .progress)
    }
}
