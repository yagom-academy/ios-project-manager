//
//  TodoDetailViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import XCTest
import Combine
@testable import ProjectManager

class TodoDetailViewModelTests: XCTestCase {
    let useCase = FakeTodoListUseCase()
    var todoListViewModel: TodoListViewModel!
    var viewModel: TodoDetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        todoListViewModel = TodoListViewModel(useCase: useCase)
    }

    func test_todoListModel의title과content가비어있는상태에서_viewDidDisppear하면_마지막아이템이지워진다() {
        // given
        viewModel = TodoDetailViewModel(useCase: useCase, todoListModel: Todo(title: "", content: "", deadLine: Date()))
        
        let expectation = XCTestExpectation(description: "closeButtonDidTap")
        let expected = 2
        var result = 0
        
        // when
        viewModel.viewDidDisapper(title: "", content: "")
        _ = todoListViewModel.todoItems.sink { items in
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
    
    func test_todoListModel의title과content가비어있지않은상태에서_doneButtonDidTap하면_아이템이업데이트되어야한다() {
        // given
        viewModel = TodoDetailViewModel(useCase: useCase, todoListModel: Todo(title: "Mock", content: "Mock", deadLine: Date(), id: "3"))
        
        let expectation = XCTestExpectation(description: "doneButtonDidTap")
        let expected = "changed Mock"
        var result: (title: String, content: String) = ("", "")

        // when
        viewModel.didTapDoneButton(title: expected, content: expected, deadLine: Date())
        _ = todoListViewModel.todoItems.sink { items in
            let item = items.first(where: { $0.id == "3" })!
            result = (item.title, item.content)
            expectation.fulfill()
        }

        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result.title, expected)
        XCTAssertEqual(result.content, expected)
    }
}
