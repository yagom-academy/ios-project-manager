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
    
    var historyUseCase: StubTodoHistoryUseCase!
    var todoUseCase: StubTodoUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        historyUseCase = StubTodoHistoryUseCase()
        todoUseCase = StubTodoUseCase()
        
        viewModel = TodoListViewModel(todoUseCase: todoUseCase, historyUseCase: historyUseCase)
    }
    
    func test_deleteItem하면_todoItems가방출하는배열의원소가하나줄어들어야한다() {
        // given
        let expectation = XCTestExpectation(description: "deleteItem")
        let mockTodoListModel = todoUseCase.items.value.last!
        let expected = todoUseCase.items.value.count - 1
        var result = 0
        
        // when
        viewModel.deleteItem(mockTodoListModel)
        
        print(mockTodoListModel)
        
        _ = viewModel.todoItems.sink { items in
            print(items)
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
    
    func test_deleteItem하면_historyUseCase의배열에원소가하나추가되야한다() {
        // given
        let expectation = XCTestExpectation(description: "deleteItem")
        let mockTodoListModel = Todo.dummyData().last!
        let expected = 1
        var result = 0
        
        // when
        viewModel.deleteItem(mockTodoListModel)
        
        _ = viewModel.historyItems.sink { items in
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
    
    func test_didTapContextMenu하면_업데이트한processType으로바뀌어야한다() {
        // given
        let expectation = XCTestExpectation(description: "cellDidLongPress")
        
        let firstModel = todoUseCase.items.value.first!
        let secondModel = todoUseCase.items.value.last!
        
        var firstResult = Todo.empty()
        var secondResult = Todo.empty()

        // when
        viewModel.didTapFirstContextMenu(firstModel)
        
        _ = viewModel.todoItems.sink { items in
            firstResult = items.first { $0.id == firstModel.id }!
            expectation.fulfill()
        }

        viewModel.didTapSecondContextMenu(secondModel)
        
        _ = viewModel.todoItems.sink { items in
            secondResult = items.first { $0.id == secondModel.id }!
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(firstModel, firstResult)
        XCTAssertEqual(secondModel, secondResult)
    }
    
    func test_didTapContextMenu하면_historyUseCase의배열에원소가하나추가되야한다() {
        // given
        let expectation = XCTestExpectation(description: "cellDidLongPress")
        let mockTodoListModel = todoUseCase.items.value.first!
        
        let expected = 1
        var result = 0
        
        // when
        viewModel.didTapFirstContextMenu(mockTodoListModel)
        
        _ = viewModel.historyItems.sink { items in
            result += 1
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expected, result)
    }
}
