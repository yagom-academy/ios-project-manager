//
//  TodoListUseCaseTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/29.
//

import XCTest
import RxSwift
import RxRelay
@testable import ProjectManager

extension History: Equatable {
    public static func == (lhs: History, rhs: History) -> Bool {
         return lhs.createAt == rhs.createAt
    }
}

class TodoListUseCaseTest: XCTestCase {
    var listRepository: MockListRepository!
    var historyRepository: MockHistoryRepository!
    var useCase: DefaultTodoListUseCase!
    
    let dummyList: [TodoModel] = [.init(),
                                  .init(),
                                  .init()]
    
    let dummyHistory: [History] = [.init(changes: .added, title: "todo"),
                                   .init(changes: .removed, title: "done", beforeState: .done)]
    
    let bag = DisposeBag()
    override func setUpWithError() throws {
        listRepository = MockListRepository()
        historyRepository = MockHistoryRepository()
        
        useCase = .init(listRepository: listRepository, historyRepository: historyRepository)
    }

    override func tearDownWithError() throws {
        listRepository = nil
        historyRepository = nil
        useCase = nil
    }
    
    func test_listRepository에_저장되있는_값을_잘_읽어오는지() {
        // given
        listRepository.storage.onNext(dummyList)
            
        // when
        useCase.readItems()
            .bind { items in
                // then
                XCTAssertEqual(items, self.dummyList)
                XCTAssertEqual(self.listRepository.actions.last!, ListRepositoryAction.read)
                XCTAssertEqual(self.listRepository.actions.count, 1)
            }.disposed(by: bag)
    }
    
    func test_historyRepository에_저장되있는_값을_잘_읽어오는지() {
        // given
        historyRepository.storage.onNext(dummyHistory)
        
        // when
        useCase.readHistoryItems()
            .bind { items in
                // then
                XCTAssertEqual(items, self.dummyHistory)
                XCTAssertEqual(self.historyRepository.actions.last!, HistoryRepositoryAction.read)
                XCTAssertEqual(self.historyRepository.actions.count, 1)
            }.disposed(by: bag)
    }
    
    func test_UseCase를_통해_item을_생성했을때_각_Repository에_값을_저장하는지() {
        // given
        let item = TodoModel(title: "사파리", body: "사파리")
        
        // when
        useCase.createItem(to: item)
        
        // then
        listRepository.verify(item: item, actions: [.create], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .added, actions: [.save], actionCount: 1)
        
    }
    
    func test_UseCase를_통해_item을_수정했을때_listRepository에_값을_저장하는지() {
        // given
        let item = TodoModel(title: "사파리", body: "사파리")
        
        // when
        useCase.updateItem(to: item)
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
    }
    
    func test_UesCase를_통해_item을_삭제했을때_각_Repository에_값을_저장하는지() {
        // given
        let item = TodoModel(title: "사파리", body: "사파리")
        listRepository.storage.onNext([item])
        
        // when
        useCase.deleteItem(id: item.id)
        
        // then
        listRepository.verify(item: item, actions: [.read, .delete], actionCount: 2)
        historyRepository.verify(title: "사파리", changes: .removed, beforeState: .todo, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_todo인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리")
        let beforeState = item.state
        let afterState: State = .doing
        
        // when
        useCase.firstMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_todo인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리")
        let beforeState = item.state
        let afterState: State = .done
        
        // when
        useCase.secondMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_doing인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리", state: .doing)
        let beforeState = item.state
        let afterState: State = .todo
        
        // when
        useCase.firstMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_doing인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리", state: .doing)
        let beforeState = item.state
        let afterState: State = .done
        
        // when
        useCase.secondMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_done인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리", state: .done)
        let beforeState = item.state
        let afterState: State = .todo
        
        // when
        useCase.firstMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_UesCase를_통해_State가_done인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        // given
        var item = TodoModel(title: "사파리", body: "사파리", state: .done)
        let beforeState = item.state
        let afterState: State = .doing
        
        // when
        useCase.secondMoveState(item: item)
        item.state = afterState
        
        // then
        listRepository.verify(item: item, actions: [.update], actionCount: 1)
        historyRepository.verify(title: "사파리", changes: .moved, afterState: afterState, beforeState: beforeState, actions: [.save], actionCount: 1)
    }
    
    func test_Repository가_방출한_Error를_전달받는지() {
        useCase.errorObserver
            .bind { error in
                XCTAssertEqual(error, TodoError.saveError)
            }.disposed(by: bag)
    }
}
