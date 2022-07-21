//
//  TodoViewModelTests.swift
//  ProjectManagerTests
//
//  Created by 조민호 on 2022/07/21.
//

import XCTest
import Combine

@testable import ProjectManager

class TodoViewModelTests: XCTestCase {
    var mockTodoViewModel: MockTodoListViewModel!
    var viewModel: TodoViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockTodoViewModel = MockTodoListViewModel()
        viewModel = TodoViewModel(processType: .todo, items: Just([]).eraseToAnyPublisher())
        viewModel.delegate = mockTodoViewModel
    }
    
    func test_deleteItem을호출했을때_deleteItemCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        viewModel.deleteItem(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoViewModel.deleteItemCallCount)
    }
    
    func test_didTapCell을호출했을때_didTapCellCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        viewModel.didTapCell(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoViewModel.didTapCellCallCount)
    }
    
    func test_didTapFirstContextMenu을호출했을때_didTapFirstContextMenuCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        viewModel.didTapFirstContextMenu(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoViewModel.didTapFirstContextMenuCallCount)
    }
    
    func test_didTapSecondContextMenu을호출했을때_didTapSecondContextMenuCallCount가하나늘어난다() {
        // given
        let expected = 1
        
        // when
        viewModel.didTapSecondContextMenu(Todo.empty())
        
        // then
        XCTAssertEqual(expected, mockTodoViewModel.didTapSecondContextMenuCallCount)
    }
}
