//
//  TodoListViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import XCTest
import Combine
@testable import ProjectManager

class TodoListViewModelTests: XCTestCase {
    var viewModel: TodoListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = TodoListViewModel(useCase: FakeTodoListUseCase())
    }

    func test_addButtonDidTap하면_todoItems가방출하는배열의원소가하나늘어나야한다() {
        // given
        let expectation = XCTestExpectation(description: "addButtonDidTap")
        let expected = 4
        var result: [TodoListModel] = []
        
        // when
        viewModel.didTapAddButton()
        _ = viewModel.items.sink { items in
            result = items
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result.count, expected)
    }
    
    func test_didTapContextMenu하면_업데이트한processType으로바뀌어야한다() {
        // given
        let deadLine = Date()
        let expectation = XCTestExpectation(description: "cellDidLongPress")
        let expected1 = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .done, id: "1")
        let expected2 = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .doing, id: "2")
        var result1: TodoListModel = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine)
        var result2: TodoListModel = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .doing)
        
        // when
        viewModel.didTapFirstContextMenu(expected1)
        _ = viewModel.items.sink { items in
            result1 = items.first(where: { $0.id == "1" })!
            expectation.fulfill()
        }
        
        viewModel.didTapSecondContextMenu(expected2)
        _ = viewModel.items.sink { items in
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
        _ = viewModel.items.sink { items in
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
}
