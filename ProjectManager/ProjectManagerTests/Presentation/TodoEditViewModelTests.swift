//
//  TodoEditViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/08.
//

import XCTest
import Combine
@testable import ProjectManager

class TodoEditViewModelTests: XCTestCase {
    var viewModel: TodoEditViewModel!
    var historyUseCase: StubTodoHistoryUseCase!
    var todoUseCase: StubTodoUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        historyUseCase = StubTodoHistoryUseCase()
        todoUseCase = StubTodoUseCase()
        
        viewModel = TodoEditViewModel(todoUseCase: todoUseCase, historyUseCase: historyUseCase, todoListModel: todoUseCase.items.value.last!)
    }

    func test_didTapDoneButton하면_item의title과content와deadline이업데이트되어야한다() {
        
        // given
        let mockTodoItem = todoUseCase.items.value.last!
        
        let expectation = XCTestExpectation(description: "didTapDoneButton")
        let expectedTitle = "제목입니다"
        let expectedContent = "내용입니다"
        var resultTitle = ""
        var resultContent = ""
        
        // when
        viewModel.didTapDoneButton(title: expectedTitle, content: expectedContent, deadline: Date())
        
        _ = todoUseCase.items.sink { items in
            let result = items.first(where: {$0.id == mockTodoItem.id})!
            resultTitle = result.title
            resultContent = result.content
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(resultTitle, expectedTitle)
        XCTAssertEqual(resultContent, expectedContent)
    }
    
    func test_didTapDoneButton하면_history에Item이추가되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "didTapDoneButton")
        let expected = 1
        var result = 0
        
        // when
        viewModel.didTapDoneButton(title: "테스트입니다", content: "내용입니다", deadline: Date())
        
        _ = historyUseCase.items.sink { items in
            result += 1
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
}
