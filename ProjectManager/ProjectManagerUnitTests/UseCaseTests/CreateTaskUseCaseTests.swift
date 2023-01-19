//
//  CreateTaskUseCaseTests.swift
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

final class CreateTaskUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: CreateTaskUseCase!
    var dispose: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = CreateTaskUseCaseMock()
        dispose = DisposeBag()
    }
    
    func test_create_success() {
        usecase.isCreatedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            }).disposed(by: dispose)
        
        usecase.create(
            title: "제목제목제목",
            content: "내용내용내용",
            deadLine: 1674148800
        )
    }
}

