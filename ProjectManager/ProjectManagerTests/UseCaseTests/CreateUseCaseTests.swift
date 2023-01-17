//
//  CreateUseCaseTests.swift
//  ProjectManager
//
//  Created by 이정민 on 2023/01/17.
//

import XCTest

final class CreateUseCaseTests: XCTestCase {
    var taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
    var usecase: CreateUseCase? = nil
    
    override func setUpWithError() throws {
        self.taskRepositoryMock = MockTaskRepository(taskEntities: TaskEntityDummy.dummys)
        self.usecase = CreateUseCase(
            delegate: EndEditTask(),
            repository: taskRepositoryMock
        )
    }
    
    func test_create_success() {
        guard let usecase = usecase else {
            return XCTFail()
        }
        
        usecase.createResult
            .subscribe(ObserverType)
    }
}

struct EndEditTask: DidEndEditTaskDelegate {
    func didEndEdit(task: Task) {
        return
    }
}
