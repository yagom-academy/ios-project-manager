//
//  HistoryViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class HistoryViewModelTest: XCTestCase {
    var useCase: TodoListUseCase!
    var viewModel: DefaultTodoHistoryViewModel!
    let bag = DisposeBag()
    let item = TodoModel(title: "사파리", body: "사파리")
    override func setUpWithError() throws {
        useCase = MockUseCase()
        viewModel = .init(useCase: useCase)
        useCase.createItem(to: item)
    }

    override func tearDownWithError() throws {
        useCase = nil
        viewModel = nil
    }
    
    func test_item을_생성했을때_올바른_HistoryTitle을_방출하는지() {
        // given
        let historyItem = try! useCase.readHistoryItems().value().last!
        
        // when
        viewModel.historyList
            .bind { cellItems in
                let value = cellItems.last!.title
                // then
                XCTAssertEqual(value, "\(historyItem.changes.rawValue) '\(historyItem.title)'")
            }.disposed(by: bag)
    }
    
    func test_item의_State를_변경_했을때_올바른_HistoryTitle을_방출하는지() {
        // given
        useCase.firstMoveState(item: item)
        let historyItem = try! useCase.readHistoryItems().value().last!
        
        // when
        viewModel.historyList
            .bind { cellItems in
                let value = cellItems.last!.title
                // then
                XCTAssertEqual(value, "\(historyItem.changes.rawValue) '\(historyItem.title)' from \(historyItem.beforeState!.rawValue) to \(historyItem.afterState!.rawValue)")
            }.disposed(by: bag)
    }
    
    func test_item을_삭제_했을때_올바른_HistoryTitle을_방출하는지() {
        // given
        useCase.deleteItem(id: item.id)
        let historyItem = try! useCase.readHistoryItems().value().last!
        
        // when
        viewModel.historyList
            .bind { cellItems in
                let value = cellItems.last!.title
                // then
                XCTAssertEqual(value, "\(historyItem.changes.rawValue) '\(historyItem.title)' from \(historyItem.beforeState!.rawValue)")
            }.disposed(by: bag)
    }
}
