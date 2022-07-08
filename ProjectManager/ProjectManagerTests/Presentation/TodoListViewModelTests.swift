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
    var viewModel: DefaultTodoListViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = DefaultTodoListViewModel(useCase: TodoListUseCaseMock())
    }

    func test_addButtonDidTap하면_todoItems가방출하는배열의원소가하나늘어나야한다() {
        // given
        let expectation = XCTestExpectation(description: "addButtonDidTap")
        let expected = 4
        var result: [TodoListModel] = []
        
        viewModel.addButtonDidTap()
        
        // when
        _ = viewModel.todoItems.sink { items in
            result = items
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result.count, expected)
    }
    
    func test_cellDidLongPress하면_업데이트한processType으로바뀌어야한다() {
        // given
        let deadLine = Date()
        let expectation = XCTestExpectation(description: "cellDidLongPress")
        let mockTodoListModel = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .todo, id: "1")
        let expected = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine, processType: .doing, id: "1")
        var result: TodoListModel = TodoListModel(title: "Mock", content: "Mock", deadLine: deadLine)

        // when
        viewModel.cellDidLongPress(mockTodoListModel, to: .doing)
        _ = viewModel.doingItems.sink { items in
            result = items.first(where: { $0.id == "1" })!
            expectation.fulfill()
        }
                    
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
    
    func test_deleteItem하면_todoItems가방출하는배열의원소가하나줄어들어야한다() {
        // given
        let expectation = XCTestExpectation(description: "deleteItem")
        let mockTodoListModel = TodoListModel(title: "2", content: "2", deadLine: Date(), processType: .todo, id: "2")
        let expected = 2
        var result = 0
        
        // when
        viewModel.deleteItem(mockTodoListModel)
        _ = viewModel.todoItems.sink { items in
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
}
