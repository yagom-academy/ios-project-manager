//
//  UpdateTaskUseCaseTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/17.
//

import XCTest

import RxSwift

private final class DidEndUpdatingDelegateStub: DidEndUpdatingDelegate {
    func didEndUpdating(task: Task) {
        return
    }
}

final class UpdateTaskUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: UpdateTaskUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = DefaultUpdateTaskUseCase(
            delegate: DidEndUpdatingDelegateStub(),
            repository: taskRepositoryMock
        )
        disposeBag = DisposeBag()
    }
    
    func test_update_task_success() {
        // given
        var previousTasks: [Task] = []
        let task = Task(
            id: "1",
            title: "RxSwift 추가할까?",
            content: "제곧내는 뭔데?",
            deadLine: 1674140700,
            state: .done
        )
        
        taskRepositoryMock.fetchAllTaskList()
            .map { $0.compactMap { Translater().toDomain(with: $0) } }
            .subscribe(onNext: { tasks in
                previousTasks = tasks
            })
            .disposed(by: disposeBag)
        usecase.isUpdatedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            })
            .disposed(by: disposeBag)
        
        // when
        usecase.update(task)
        
        // then
        taskRepositoryMock.fetchAllTaskList()
            .map { $0.compactMap { Translater().toDomain(with: $0) } }
            .subscribe(onNext: { updatedTasks in
                guard let updatedTask = updatedTasks.first(where: {$0.id == task.id}),
                      let previousTask = previousTasks.first(where: { $0.id == task.id }) else {
                    return XCTFail()
                }
                
                XCTAssertNotEqual(previousTask.title, task.title)
                XCTAssertNotEqual(previousTask.content, task.content)
                XCTAssertNotEqual(previousTask.deadLine, task.deadLine)
                XCTAssertNotEqual(previousTask.state, task.state)
                XCTAssertEqual(updatedTask.title, task.title)
                XCTAssertEqual(updatedTask.content, task.content)
                XCTAssertEqual(updatedTask.deadLine, task.deadLine)
                XCTAssertEqual(updatedTask.state, task.state)
            })
            .disposed(by: disposeBag)
    }
    
    func test_update_task_failure() {
        // given
        let task = Task(
            id: "noID",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1674140400, // 2023년
            state: .toDo
        )
        
        usecase.isUpdatedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertFalse(isSuccess)
            })
            .disposed(by: disposeBag)
        
        // when, then
        usecase.update(task)
    }
}
