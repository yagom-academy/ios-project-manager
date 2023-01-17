//
//  CreateUseCaseTests.swift
//  ProjectManager
//
//  Created by ayaan, jpush on 2023/01/17.
//

import XCTest

import RxSwift

private final class EndEditTask: DidEndCreatingTaskDelegate {
    func didEndCreating(task: Task) {
        return
    }
}

final class CreateUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: CreateUseCase!
    var dispose: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = CreateUseCase(
            delegate: EndEditTask(),
            repository: taskRepositoryMock
        )
        dispose = DisposeBag()
    }
    
    func test_create_success() {
        usecase.isCreatedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            }).disposed(by: dispose)
        
        usecase.addTask(Task(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: "Jan 20, 2023",
            state: .toDo,
            isExpired: true
        ))
    }
    
    func test_create_failure() {
        usecase.isCreatedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertFalse(isSuccess)
            }).disposed(by: dispose)
        
        usecase.addTask(Task(
            id: UUID().uuidString,
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: "Jan 54, 2023",
            state: .toDo,
            isExpired: true
        ))
    }
}

