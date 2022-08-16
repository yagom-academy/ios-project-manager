//
//  TodoMoveViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class TodoMoveViewModelTest: XCTestCase {
    var viewModel: DefaultTodoMoveViewModel!
    var useCase: MockUseCase!
    let bag = DisposeBag()
    
    override func setUpWithError() throws {
        useCase = MockUseCase()
    }

    override func tearDownWithError() throws {
        useCase = nil
    }
    
    func test_선택된_item의_State가_todo일때_올바른_ButtonTitle이_나오는지() {
        // given
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        // wheb
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                //then
                XCTAssertEqual(firstButtonTitle, "Move to DOING")
                XCTAssertEqual(secondButtonTitle, "Move to DONE")
            }.disposed(by: bag)
    }
    
    func test_선택된_item의_State가_doing일때_올바른_ButtonTitle이_나오는지() {
        // given
        let doingItme = TodoModel(title: "doing", body: "doing", state: .doing)
        viewModel = .init(useCase: useCase, item: doingItme)
        
        // when
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                // then
                XCTAssertEqual(firstButtonTitle, "Move to TODO")
                XCTAssertEqual(secondButtonTitle, "Move to DONE")
            }.disposed(by: bag)
    }
    
    func test_선택된_item의_State가_done일때_올바른_ButtonTitle이_나오는지() {
        // given
        let doneItme = TodoModel(title: "done", body: "done", state: .done)
        viewModel = .init(useCase: useCase, item: doneItme)
        
        // when
        viewModel.buttonTitle
            .bind { (firstButtonTitle, secondButtonTitle) in
                // then
                XCTAssertEqual(firstButtonTitle, "Move to TODO")
                XCTAssertEqual(secondButtonTitle, "Move to DOING")
            }.disposed(by: bag)
    }
    
    func test_firstButton을_Tap했을때_UseCase의_firstMoveState메서드를_호출하는지() {
        //given
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        // when
        viewModel.firstButtonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, todoItme.id)
        XCTAssertEqual(useCase.actions.last!, UseCaseAction.firstMove)
        XCTAssertEqual(useCase.actions.count, 1)
    }
    
    func test_secondButton을_Tap했을때_UseCase의_secondMoveState메서드를_호출하는지() {
        //given
        let todoItme = TodoModel(title: "todo", body: "todo", state: .todo)
        viewModel = .init(useCase: useCase, item: todoItme)
        
        // when
        viewModel.secondButtonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, todoItme.id)
        XCTAssertEqual(useCase.actions.last!, UseCaseAction.secondMove)
        XCTAssertEqual(useCase.actions.count, 1)
    }
}
