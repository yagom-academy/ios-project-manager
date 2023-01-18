//
//  DeleteUseCaseTests.swift
//  ProjectManagerUnitTests
//
//  Created by ayaan, jpush on 2023/01/17.
//

import XCTest

import RxSwift

final class DeleteUseCaseTests: XCTestCase {
    var taskRepositoryMock: MockTaskRepository!
    var usecase: DeleteUseCase!
    var disposeBag: DisposeBag!
    
    override func setUpWithError() throws {
        taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        usecase = DeleteUseCase(
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
            deadLine: "Jan 10, 2023",
            state: .done,
            isExpired: false
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
            deadLine: "Jan 10, 2023",
            state: .done,
            isExpired: false
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
