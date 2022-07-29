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
    var useCase: TodoListUseCase!
    let bag = DisposeBag()

    override func setUpWithError() throws {
        useCase = MockUseCase()
        viewModel = DefaultTodoListViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
        useCase = nil
        viewModel = nil
    }
    
    func test_State가_todo인_item이_1개있을때_성공케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo",
                                  state: .todo)
        useCase.createItem(to: todoItem)
        
        // when
        viewModel.todoListCount
            .drive {
                // then
                XCTAssertEqual($0, "1")
            }.disposed(by: bag)
    }
    
    func test_State가_todo인_item이_1개있을때_실패케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo",
                                  state: .todo)
        useCase.createItem(to: todoItem)
        
        // when
        viewModel.todoListCount
            .drive {
                // then
                XCTAssertFalse($0 == "3")
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item이_1개있을때_성공케이스() {
        // given
        let doingItem = TodoModel(title: "doing",
                                  body: "doing",
                                  state: .doing)
        useCase.createItem(to: doingItem)
        
        // when
        viewModel.doingListCount
            .drive {
                // then
                XCTAssertTrue($0 == "1")
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item이_1개있을때_실패케이스() {
        // given
        let doingItem = TodoModel(title: "doing",
                                  body: "doing",
                                  state: .doing)
        useCase.createItem(to: doingItem)
        
        // when
        viewModel.doingListCount
            .drive {
                // then
                XCTAssertFalse($0 == "0")
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item이_1개있을때_성공케이스() {
        // given
        let doneItem = TodoModel(title: "done",
                                  body: "done",
                                  state: .done)
        useCase.createItem(to: doneItem)
        
        // when
        viewModel.doneListCount
            .drive {
                // then
                XCTAssertTrue($0 == "1")
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item이_1개있을때_실패케이스() {
        // given
        let doneItem = TodoModel(title: "done",
                                  body: "done",
                                  state: .done)
        useCase.createItem(to: doneItem)
        
        // when
        viewModel.doneListCount
            .drive {
                // then
                XCTAssertFalse($0 == "0")
            }.disposed(by: bag)
    }
    
    func test_State가_todo인_item을_생성했을때_방출된값이_생성한_item과_같은지_성공케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo",
                                  state: .todo)
        useCase.createItem(to: todoItem)
        // when
        viewModel.todoList
            .bind { items in
                // then
                XCTAssertEqual(items.first!.id, todoItem.id)
            }.disposed(by: bag)
    }
    
    func test_State가_todo인_item을_생성했을때_방출된값이_생성한_item과_같은지_실패케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo",
                                  state: .todo)
        useCase.createItem(to: todoItem)
        // when
        viewModel.todoList
            .bind { items in
                // then
                XCTAssertNotEqual(items.first!.id, UUID())
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item을_생성했을때_방출된값이_생성한_item과_같은지_성공케이스() {
        // given
        let doingItem = TodoModel(title: "doing",
                                  body: "doing",
                                  state: .doing)
        useCase.createItem(to: doingItem)
        // when
        viewModel.doingList
            .bind { items in
                // then
                XCTAssertEqual(items.first!.id, doingItem.id)
            }.disposed(by: bag)
    }
    
    func test_State가_doing인_item을_생성했을때_방출된값이_생성한_item과_같은지_실패케이스() {
        // given
        let doingItem = TodoModel(title: "doing",
                                  body: "doing",
                                  state: .doing)
        useCase.createItem(to: doingItem)
        // when
        viewModel.doingList
            .bind { items in
                // then
                XCTAssertNotEqual(items.first!.id, UUID())
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item을_생성했을때_방출된값이_생성한_item과_같은지_성공케이스() {
        // given
        let doneItem = TodoModel(title: "done",
                                  body: "done",
                                  state: .done)
        useCase.createItem(to: doneItem)
        // when
        viewModel.doneList
            .bind { items in
                // then
                XCTAssertEqual(items.first!.id, doneItem.id)
            }.disposed(by: bag)
    }
    
    func test_State가_done인_item을_생성했을때_방출된값이_생성한_item과_같은지_실패케이스() {
        // given
        let doneItem = TodoModel(title: "done",
                                  body: "done",
                                  state: .done)
        useCase.createItem(to: doneItem)
        // when
        viewModel.doneList
            .bind { items in
                // then
                XCTAssertNotEqual(items.first!.id, UUID())
            }.disposed(by: bag)
    }
    
    func test_todoItem을_생성하고_select되었을때_생성한_item과_select된_item이_같은지_성공케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo")
        
        // when
        useCase.createItem(to: todoItem)
        let selectItem = viewModel.cellSelected(id: todoItem.id)
        
        // then
        XCTAssertEqual(todoItem, selectItem)
    }
    
    func test_todoItem을_생성하고_select되었을때_생성한_item과_select된_item이_같은지_실패케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo")
        let doingItem = TodoModel(title: "doing",
                                  body: "doing",
                                  state: .doing)
        
        // when
        useCase.createItem(to: todoItem)
        let selectItem = viewModel.cellSelected(id: todoItem.id)
        
        // then
        XCTAssertNotEqual(doingItem, selectItem)
    }
    
    func test_todoItem을_생성하고_deleteButton을_눌렀을때_해당item이_삭제되는지_성공케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo")
        let cellItem = TodoCellContent(entity: todoItem,
                                       dateFormatter: DateFormatter())
        // when
        useCase.createItem(to: todoItem)
        
        // then
        XCTAssertEqual(try! useCase.readItems().value(), [todoItem])
        viewModel.cellDeleteButtonDidTap(item: cellItem)
        XCTAssertEqual(try! useCase.readItems().value(), [])
    }
    
    func test_todoItem을_생성하고_deleteButton을_눌렀을때_해당item이_삭제되는지_실패케이스() {
        // given
        let todoItem = TodoModel(title: "todo",
                                  body: "todo")
        let cellItem = TodoCellContent(entity: todoItem,
                                       dateFormatter: DateFormatter())
        // when
        useCase.createItem(to: todoItem)
        
        // then
        XCTAssertEqual(try! useCase.readItems().value(), [todoItem])
        viewModel.cellDeleteButtonDidTap(item: cellItem)
        XCTAssertNotEqual(try! useCase.readItems().value(), [todoItem])
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

