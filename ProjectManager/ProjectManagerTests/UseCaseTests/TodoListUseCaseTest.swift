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

class TodoListUseCaseTest: XCTestCase {
    var listRepository: TodoListRepository!
    var historyRepository: HistoryRepository!
    var useCase: DefaultTodoListUseCase!
    
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
    
    func test_listRepository에_저장된_todoItem과_같은_item을_읽어오는지() {
        let item = TodoModel(title: "사파리", body: "사파리")
        
        listRepository.create(to: item)
        
        useCase.readItems()
            .bind { items in
                XCTAssertEqual(items.last, item)
            }.disposed(by: bag)
    }
    
    func test_historyRepository에_저장된_historyItem과_같은_item을_읽어오는지() {
        let item = History(changes: .added, title: "사파리")
        
        historyRepository.save(to: item)
        
        useCase.readHistoryItems()
            .bind { items in
                XCTAssertEqual(items.last?.title, item.title)
            }.disposed(by: bag)
    }
    
    func test_UseCase를_통해_item을_생성했을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리")
        
        useCase.createItem(to: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem, item)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.added)
    }
    
    func test_UseCase를_통해_item을_수정했을때_listRepository에_값을_저장하는지() {
        var item = TodoModel(title: "사파리", body: "사파리")
        useCase.createItem(to: item)
        item.title = "todo"
        useCase.updateItem(to: item)
        
        let todoItem = try! listRepository.read().value().last
        
        XCTAssertEqual(todoItem, item)
    }
    
    func test_UesCase를_통해_item을_삭제했을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리")
        useCase.createItem(to: item)
        useCase.deleteItem(id: item.id)
        
        let todoItem = try? listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertNil(todoItem)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.removed)
    }
    
    func test_UesCase를_통해_State가_todo인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리")
        useCase.createItem(to: item)
        useCase.firstMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.doing)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_UesCase를_통해_State가_todo인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리")
        useCase.createItem(to: item)
        useCase.secondMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.done)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_UesCase를_통해_State가_doing인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리", state: .doing)
        useCase.createItem(to: item)
        useCase.firstMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.todo)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_UesCase를_통해_State가_doing인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리", state: .doing)
        useCase.createItem(to: item)
        useCase.secondMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.done)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_UesCase를_통해_State가_done인_item을_첫번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리", state: .done)
        useCase.createItem(to: item)
        useCase.firstMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.todo)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_UesCase를_통해_State가_done인_item을_두번째_State로_이동시켰을때_각_Repository에_값을_저장하는지() {
        let item = TodoModel(title: "사파리", body: "사파리", state: .done)
        useCase.createItem(to: item)
        useCase.secondMoveState(item: item)
        
        let todoItem = try! listRepository.read().value().last
        let hitoryItem = try! historyRepository.read().value().last
        
        XCTAssertEqual(todoItem?.id, item.id)
        XCTAssertEqual(todoItem?.state, State.doing)
        XCTAssertEqual(hitoryItem?.title, item.title)
        XCTAssertEqual(hitoryItem?.changes, Changes.moved)
    }
    
    func test_Repository가_방출한_Error를_전달받는지() {
        useCase.errorObserver
            .bind { error in
                XCTAssertEqual(error, TodoError.saveError)
            }.disposed(by: bag)
    }
}
