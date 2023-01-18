//
//  FetchTasksUseCaseTests.swift
//  ProjectManagerUnitTests
//
//  Created by Ayaan on 2023/01/18.
//

import XCTest

import RxSwift

final class FetchTasksUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: FetchTasksUseCase!
    var dispose: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = FetchTasksUseCase(
            taskRepository: taskRepositoryMock
        )
        dispose = DisposeBag()
    }
    
    func test_fetch_success() {
        //given
        var tasksList: [Task]? = nil
        usecase.tasks
            .subscribe(onNext: { tasks in
                tasksList = tasks
            })
            .disposed(by: dispose)
        
        //when, then
        usecase.fetchTasks()
        XCTAssertNotNil(tasksList)
    }
    
    func test_when_creating_task_is_successful_then_renewing_tasksList_is_successful() {
        let createUseCaseStub = CreateTaskUseCase(delegate: usecase,
                                                  repository: taskRepositoryMock)
        var tasksList: [Task]? = nil
        var previousTasksListCount: Int? = nil
        var currentTasksListCount: Int? = nil
        usecase.tasks
            .subscribe(onNext: { tasks in
                previousTasksListCount = tasksList?.count
                tasksList = tasks
                currentTasksListCount = tasksList?.count
            })
            .disposed(by: dispose)
        
        usecase.fetchTasks()
        XCTAssertNotNil(tasksList)
        
        createUseCaseStub.addTask(Task(id: "TestCase",
                                       title: "Test",
                                       content: "Test",
                                       deadLine: "Jan 20, 2023",
                                       state: .toDo,
                                       isExpired: false))
        
        guard let previousTasksListCount = previousTasksListCount,
              let currentTasksListCount = currentTasksListCount else {
            return XCTFail()
        }
        
        XCTAssertNotEqual(previousTasksListCount, currentTasksListCount)
        XCTAssertEqual(previousTasksListCount + 1, currentTasksListCount)
    }
    
    func test_when_updating_task_is_successful_then_renewing_tasksList_is_successful() {
        let updateUseCaseStub = UpdateTaskUseCase(delegate: usecase,
                                                  repository: taskRepositoryMock)
        var tasksList: [Task]? = nil
        usecase.tasks
            .subscribe(onNext: { tasks in
                tasksList = tasks
            })
            .disposed(by: dispose)
        
        usecase.fetchTasks()
        XCTAssertNotNil(tasksList)
        
        guard var targetTask = TaskDummy.dummys.first,
              let previousTask = tasksList?.first else {
            return XCTFail()
        }
        XCTAssertEqual(targetTask.state, previousTask.state)
        targetTask.state = .done
        XCTAssertNotEqual(targetTask.state, previousTask.state)
        
        updateUseCaseStub.update(targetTask)
        
        guard let currentTask = tasksList?.first else { return XCTFail() }
        XCTAssertEqual(targetTask.state, currentTask.state)
        XCTAssertNotEqual(previousTask.state, currentTask.state)
    }
    
    func test_when_updating_task_is_failed_then_tasksList_is_not_renewed() {
        let updateUseCaseStub = UpdateTaskUseCase(delegate: usecase,
                                                  repository: taskRepositoryMock)
        var tasksList: [Task]? = nil
        usecase.tasks
            .subscribe(onNext: { tasks in
                tasksList = tasks
            })
            .disposed(by: dispose)
        
        usecase.fetchTasks()
        XCTAssertNotNil(tasksList)
        
        let targetTask = Task(id: .init(),
                              title: .init(),
                              content: .init(),
                              deadLine: .init(),
                              state: .done,
                              isExpired: false)
        
        guard let previousTask = tasksList?.first else { return XCTFail() }
        
        updateUseCaseStub.update(targetTask)
        
        guard let currentTask = tasksList?.first else { return XCTFail() }
        XCTAssertEqual(previousTask.state, currentTask.state)
    }
}
