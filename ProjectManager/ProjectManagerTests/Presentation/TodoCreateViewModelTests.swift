import XCTest
import Combine
@testable import ProjectManager

class TodoCreateViewModelTests: XCTestCase {
    var viewModel: TodoCreateViewModel!
    var historyUseCase: StubTodoHistoryUseCase!
    var todoUseCase: StubTodoUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        historyUseCase = StubTodoHistoryUseCase()
        todoUseCase = StubTodoUseCase()
        
        viewModel = TodoCreateViewModel(todoUseCase: todoUseCase, historyUseCase: historyUseCase)
    }

    func test_didTapDoneButton하면_title과content와deadline을가진item이생성되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "didTapDoneButton")
        let expected = todoUseCase.items.value.count + 1
        var result = 0

        // when
        viewModel.didTapDoneButton("테스트입니다", "내용입니다", Date())
        
        _ = todoUseCase.items.sink { items in
            result = items.count
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(expected, result)
    }
    
    func test_didTapDoneButton하면_history에Item이추가되어야한다() {
        // given
        let expectation = XCTestExpectation(description: "didTapDoneButton")
        let expected = 1
        var result = 0
        
        // when
        viewModel.didTapDoneButton("제목입니다", "내용입니다", Date())
        
        _ = historyUseCase.items.sink { _ in
            result += 1
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, expected)
    }
}
