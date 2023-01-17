//
//  DeleteUseCaseTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/17.
//

import RxSwift

import XCTest

private final class EndEditTask: DidEndDeletingDelegate {
    func didEndDeleting(task: Task) {
        return
    }
}

final class DeleteUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: DeleteUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = DeleteUseCase(
            delegate: EndEditTask(),
            repository: taskRepositoryMock
        )
        disposeBag = DisposeBag()
    }
    
    func test_delete_task_success() {
        // given
        guard let task = Translater().toDomain(with: TaskEntity(
            id: "1",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1675436400, // 2023년
            state: 3
        )) else { return }
        
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
        guard let task = Translater().toDomain(with: TaskEntity(
            id: "noID",
            title: "RxSwift 추가",
            content: "제곧내",
            deadLine: 1675436400, // 2023년
            state: 3
        )) else { return }
        
        usecase.isDeletedSuccess
            .subscribe(onNext: { isSuccess in
                XCTAssertFalse(isSuccess)
            })
            .disposed(by: disposeBag)
        
        // when, then
        usecase.deleteTask(task)
    }
}
