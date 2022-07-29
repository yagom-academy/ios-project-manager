//
//  TodoListUseCaseTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import XCTest
import RxSwift
import RxRelay
@testable import ProjectManager

class TodoListUseCaseTest: XCTestCase {
    var listRepository: TodoListRepository!
    var historyRepository: HistoryRepository!
    var useCase: DefaultTodoListUseCase!
    
    override func setUpWithError() throws {
        listRepository = MockListRepository()
        historyRepository = MockHistoryRepository()
        
        useCase = .init(listRepository: listRepository, historyRepository: historyRepository)
    }

    override func tearDownWithError() throws {
        listRepository = nil
        historyRepository = nil
        useCase = nil
    }
}
