//
//  TodoMoveViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import Foundation
import XCTest
import RxSwift
@testable import ProjectManager

class TodoMoveViewModelTest: XCTestCase {
    var viewModel: DefaultTodoMoveViewModel!
    var useCase: TodoListUseCase!
    let bag = DisposeBag()
    
    override func setUpWithError() throws {
        useCase = MockUseCase()
    }

    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func test_선택된_item의_State가_todo일때_올바른_ButtonTitle이_나오는지() {
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                XCTAssertEqual(firstButtonTitle, "Move to DOING")
                XCTAssertEqual(secondButtonTitle, "Move to DONE")
            }.disposed(by: bag)
    }
    
    func test_선택된_item의_State가_doing일때_올바른_ButtonTitle이_나오는지() {
        let doingItme = TodoModel(title: "doing", body: "doing", state: .doing)
        viewModel = .init(useCase: useCase, item: doingItme)
        
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                XCTAssertEqual(firstButtonTitle, "Move to TODO")
                XCTAssertEqual(secondButtonTitle, "Move to DONE")
            }.disposed(by: bag)
    }
    
    func test_선택된_item의_State가_done일때_올바른_ButtonTitle이_나오는지() {
        let doneItme = TodoModel(title: "done", body: "done", state: .done)
        viewModel = .init(useCase: useCase, item: doneItme)
        
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                XCTAssertEqual(firstButtonTitle, "Move to TODO")
                XCTAssertEqual(secondButtonTitle, "Move to DOING")
            }.disposed(by: bag)
    }
    
    func test_Stated가_todo인_item을_firstButton을_Tap했을때_State가_doing으로_업데이트되는지() {
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        useCase.createItem(to: todoItme)
        viewModel.firstButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.doing)
    }
    
    func test_Stated가_todo인_item을_secondButton을_Tap했을때_State가_done로_업데이트되는지() {
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        useCase.createItem(to: todoItme)
        viewModel.secondButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.done)
    }
    
    func test_Stated가_doing인_item을_firstButton을_Tap했을때_State가_todo로_업데이트되는지() {
        let doingItme = TodoModel(title: "doing", body: "doing", state: .doing)
        viewModel = .init(useCase: useCase, item: doingItme)
        
        useCase.createItem(to: doingItme)
        viewModel.firstButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.todo)
    }
    
    func test_Stated가_doing인_item을_secondButton을_Tap했을때_State가_done로_업데이트되는지() {
        let doingItme = TodoModel(title: "doing", body: "doing", state: .doing)
        viewModel = .init(useCase: useCase, item: doingItme)
        
        useCase.createItem(to: doingItme)
        viewModel.secondButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.done)
    }
    
    func test_Stated가_done인_item을_firstButton을_Tap했을때_State가_todo로_업데이트되는지() {
        let doneItme = TodoModel(title: "done", body: "done", state: .done)
        viewModel = .init(useCase: useCase, item: doneItme)
        
        useCase.createItem(to: doneItme)
        viewModel.firstButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.todo)
    }
    
    func test_Stated가_done인_item을_secondButton을_Tap했을때_State가_doing로_업데이트되는지() {
        let doneItme = TodoModel(title: "done", body: "done", state: .done)
        viewModel = .init(useCase: useCase, item: doneItme)
        
        useCase.createItem(to: doneItme)
        viewModel.secondButtonDidTap()
        let value = try! useCase.readItems().value().first
        
        XCTAssertEqual(value?.state, State.doing)
    }
}
