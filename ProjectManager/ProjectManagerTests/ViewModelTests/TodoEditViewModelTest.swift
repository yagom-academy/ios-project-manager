//
//  TodoEditViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class TodoEditViewModelTest: XCTestCase {
    var viewModel: DefaultTodoEditViewModel!
    var useCase: MockUseCase!
    let bag = DisposeBag()

    override func setUpWithError() throws {
        useCase = MockUseCase()
    }

    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func test_cell을_Tap하여_생성된_viewModel이_같은_item을_방출하는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.setUpView
            .bind { item in
                //then
                XCTAssertEqual(item, todoItem)
            }.disposed(by: bag)
    }
    
    func test_plusButton을_Tap하여_생성된_viewModel이_nil을_방출하는지() {
        // given
        viewModel = .init(useCase: useCase, item: nil)
        
        // when
        viewModel.setUpView
            .bind { item in
                //then
                XCTAssertNil(item)
            }.disposed(by: bag)
    }
    
    func test_cell을_Tap하여_생성된_viewModel이_CreateModel가_false인지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.setCreateMode
            .bind {
                XCTAssertFalse($0)
            }.disposed(by: bag)
    }
    
    func test_plusButton을_Tap하여_생성된_viewModel이_CreateModel가_true인지() {
        // given
        viewModel = .init(useCase: useCase, item: nil)
        
        // when
        viewModel.setCreateMode
            .bind {
                XCTAssertTrue($0)
            }.disposed(by: bag)
    }
    
    func test_viewModel의_item이_nil인_상태에서_title을_입력했을때_item이_생성되는지() {
        // given
        viewModel = .init(useCase: useCase, item: nil)
        
        // when
        viewModel.inputitle(title: "todo")
        
        // then
        viewModel.setUpView
            .bind {
                XCTAssertNotNil($0)
                XCTAssertEqual($0?.title, "todo")
            }.disposed(by: bag)
    }
    
    func test_viewModel의_item이_nil인_상태에서_body을_입력했을때_item이_생성되는지() {
        // given
        viewModel = .init(useCase: useCase, item: nil)
        
        // when
        viewModel.inputBody(body: "todo")
        
        // then
        viewModel.setUpView
            .bind {
                XCTAssertNotNil($0)
                XCTAssertEqual($0?.body, "todo")
            }.disposed(by: bag)
    }
    
    func test_createButton을_Tap했을때_가지고있는_item이_useCase를_통해_저장이됐는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.createButtonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, todoItem.id)
        XCTAssertEqual(useCase.actions.last!, Action.create)
        XCTAssertEqual(useCase.actions.count, 1)
    }
    
    func test_새로_title을_입력했을때_item이_수정되었는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        let newTitle = "todo"
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.inputitle(title: newTitle)
        
        // then
        viewModel.setUpView
            .bind { item in
                XCTAssertEqual(item!.id, todoItem.id)
                XCTAssertEqual(item?.title, newTitle)
            }.disposed(by: bag)
    }
    
    func test_새로_body을_입력했을때_item이_수정되었는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        let newBody = "todo"
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.inputBody(body: newBody)
        
        // then
        viewModel.setUpView
            .bind { item in
                XCTAssertEqual(item!.id, todoItem.id)
                XCTAssertEqual(item?.body, newBody)
            }.disposed(by: bag)
    }
    
    func test_새로_deadlineAt을_입력했을때_item이_수정되었는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        let newDeadlineAt = Date(timeIntervalSince1970: 10000)
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.inputDeadline(deadline: newDeadlineAt)
        
        // then
        viewModel.setUpView
            .bind { item in
                XCTAssertEqual(item!.id, todoItem.id)
                XCTAssertEqual(item?.deadlineAt, newDeadlineAt)
            }.disposed(by: bag)
    }
    
    func test_editButton를_Tap하면_EditMode가_True를_방출하는지() {
        // given
        viewModel = .init(useCase: useCase, item: nil)
        
        viewModel.setEditMode
            .bind {
                // then
                XCTAssertTrue($0)
            }.disposed(by: bag)
        
        // when
        viewModel.editButtonDidTap()
    }
    
    func test_item을_생성하고_doneButton을_Tap하면_UseCase에서_업데이트가되는지() {
        // given
        let todoItem = TodoModel(title: "사파리", body: "사파리")
        viewModel = .init(useCase: useCase, item: todoItem)
        
        // when
        viewModel.doneButtonDidTap()
        
        //then
        XCTAssertEqual(useCase.targetId, todoItem.id)
        XCTAssertEqual(useCase.actions.last!, Action.update)
        XCTAssertEqual(useCase.actions.count, 1)
    }
}
