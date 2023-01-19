//
//  DeleteTaskUseCaseTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/17.
//

import XCTest

import RxSwift

private final class DidEndDeletingDelegateStub: DidEndDeletingDelegate {
    func didEndDeleting(task: Task) {
        return
    }
}

final class DeleteTaskUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: DeleteTaskUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = DeleteTaskUseCase(
            delegate: DidEndDeletingDelegateStub(),
            repository: taskRepositoryMock
        )
        disposeBag = DisposeBag()
    }
    
    func test_delete_task_success() {
        // given
        let task = Task(
            id: "1",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1674140400, // 2023년
            state: .toDo
        )
        
        usecase.isDeletedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertTrue(isSuccess)
            })
            .disposed(by: disposeBag)
        
        // when, then
        usecase.deleteTask(task)
    }
    
    func test_delete_task_failure() {
        // given
        let task = Task(
            id: "noID",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1674140400, // 2023년
            state: .toDo
        )
        
        usecase.isDeletedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertFalse(isSuccess)
            })
            .disposed(by: disposeBag)
        
        // when, then
        usecase.deleteTask(task)
    }
}
