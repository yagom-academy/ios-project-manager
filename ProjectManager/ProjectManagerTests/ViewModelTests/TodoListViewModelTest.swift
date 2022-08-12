//
//  MockUseCase.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/26.
//

import XCTest
import RxSwift
@testable import ProjectManager

class TodoListViewModelTest: XCTestCase {
    var viewModel: TodoListViewModel!
    var useCase: MockUseCase!
    let bag = DisposeBag()
    let dummyData: [TodoModel] = [.init(title: "todo", body: "todo", state: .todo),
                                  .init(title: "doing", body: "doing", state: .doing),
                                  .init(title: "done", body: "done", state: .done),
                                 ]

    override func setUpWithError() throws {
        useCase = .init()
        viewModel = DefaultTodoListViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
        useCase = nil
        viewModel = nil
    }
    
    func test_State가_todo인_item이_1개있을때_성공케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.todoListCount
            .drive {
                // then
                XCTAssertEqual($0, "1")
            }.disposed(by: bag)
    }
    
    func test_State가_todo인_item이_1개있을때_실패케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.todoListCount
            .drive {
                // then
                XCTAssertNotEqual($0, "2")
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item이_1개있을때_성공케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.doingListCount
            .drive {
                // then
                XCTAssertEqual($0, "1")
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item이_1개있을때_실패케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.doingListCount
            .drive {
                // then
                XCTAssertNotEqual($0, "2")
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item이_1개있을때_성공케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.doneListCount
            .drive {
                // then
                XCTAssertEqual($0, "1")
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item이_1개있을때_실패케이스() {
        // given
        useCase.todoList.onNext(dummyData)
        
        // when
        viewModel.doneListCount
            .drive {
                // then
                XCTAssertNotEqual($0, "2")
            }.disposed(by: bag)
    }
    
    func test_item이_select되었을때_select된_item이_같은지_성공케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo")
        
        // when
        useCase.todoList.onNext(try! useCase.todoList.value() + [todoItem])
        let selectItem = viewModel.cellSelected(id: todoItem.id)
        
        // then
        XCTAssertEqual(todoItem, selectItem)
    }
    
    func test_UseCase가_에러를_방출했을때_뷰모델이_에러를_받는지() {
        // when
        viewModel.errorMessage
            .bind { errorMessage in
                // then
                XCTAssertEqual(errorMessage, TodoError.saveError.localizedDescription)
            }.disposed(by: bag)
    }
}

