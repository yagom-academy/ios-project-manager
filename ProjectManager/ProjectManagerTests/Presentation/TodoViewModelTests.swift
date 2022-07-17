//
//  TodoViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/13.
//

import XCTest
import Combine
@testable import ProjectManager

class TodoViewModelTests: XCTestCase {
    var parentViewModel: TodoListViewModel!
    var viewModel: TodoViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        parentViewModel = TodoListViewModel(useCase: FakeTodoListUseCase())
        viewModel = TodoViewModel(processType: .todo, items: parentViewModel.items)
        viewModel.delegate = parentViewModel
    }
    
    func test_didTapContextMenu하면_업데이트한processType으로바뀌어야한다() {
        // given
        let deadLine = Date()
        let expectation = XCTestExpectation(description: "cellDidLongPress")
        let expected1 = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .doing, id: "1")
        let expected2 = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .done, id: "2")
        var result1: TodoListModel = TodoListModel.empty
        var result2: TodoListModel = TodoListModel.empty
        
        // when
        viewModel.didTapFirstContextMenu(expected1)
        _ = parentViewModel.items.sink { items in
            result1 = items.first(where: { $0.id == "1" })!
            expectation.fulfill()
        }
        
        viewModel.didTapSecondContextMenu(expected2)
        _ = parentViewModel.items.sink { items in
            result2 = items.first(where: { $0.id == "2" })!
            expectation.fulfill()
        }
                    
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result1, expected1)
        XCTAssertEqual(result2, expected2)
    }
    
    func test_deleteItem하면_todoItems가방출하는배열의원소가하나줄어들어야한다() {
        // given
        let expectation = XCTestExpectation(description: "deleteItem")
        let mockTodoListModel = TodoListModel(title: "2", content: "2", deadLine: Date(), processType: .todo, id: "2")
        let expected = 2
        var result = 0

        // when
        viewModel.deleteItem(mockTodoListModel)
        _ = parentViewModel.items.sink { items in
            result = items.count
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
}
