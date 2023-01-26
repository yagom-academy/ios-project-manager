//
//  MainViewModelTests.swift
//  ProjectManagerTests
//  Created by inho on 2023/01/19.
//

import XCTest
@testable import ProjectManager

final class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    let listItem = ListItem(title: "Any title", body: "Any body", dueDate: Date())

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = MainViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_리스트가비어있을때_특정아이템을가져오면_nil을반환하는가() {
        //given
        let targetItem = ListItem(
            title: "목록에 없는 아이템",
            body: "",
            dueDate: Date()
        )
        
        //when
        ListType.allCases.forEach {
            let result = sut.fetch(targetItem: targetItem, from: $0)
            
            //then
            XCTAssertNil(result.0)
            XCTAssertNil(result.1)
        }
    }
    
    func test_TodoList에_item을추가했을때_TodoList의마지막에추가되는가() {
        //given
        sut.appendTodoList(item: listItem)
        
        //when
        let result = sut.fetch(targetItem: listItem, from: .todo)

        //then
        XCTAssertEqual(result.0, listItem)
    }
    
    func test_TodoList에서_DoingList로아이템을옮겼을때_변경이반영되는가() {
        //given
        sut.appendTodoList(item: listItem)
        
        //when
        sut.move(targetItem: listItem, from: .todo, to: .doing)

        //then
        let todoResult = sut.fetch(targetItem: listItem, from: .todo)
        let doingResult = sut.fetch(targetItem: listItem, from: .doing)
        
        XCTAssertNil(todoResult.0)
        XCTAssertEqual(doingResult.0, listItem)
    }
    
    func test_TodoList에서_아이템을삭제했을때_변경이반영되는가() {
        //given
        sut.appendTodoList(item: listItem)
        
        //when
        let itemAtCell = sut.fetch(targetItem: listItem, from: .todo)
        
        guard let index = itemAtCell.1 else { return }
        
        sut.delete(at: index, type: .todo)
        
        //then
        let deleteResult = sut.fetch(targetItem: listItem, from: .todo)
        
        XCTAssertNil(deleteResult.0)
    }
    
    func test_특정아이템을편집했을때_아이템에변경이반영되는가() {
        //given
        sut.appendTodoList(item: listItem)
        
        //when
        let itemAtCell = sut.fetch(targetItem: listItem, from: .todo)
        
        guard let index = itemAtCell.1 else { return }
        
        
        sut.editItem(of: .todo, at: index, title: "EditedTitle", body: "변경된 바디", dueDate: Date())
        
        //then
        let editResult = sut.fetch(targetItem: listItem, from: .todo)
        
        XCTAssertEqual(editResult.0?.title, "EditedTitle")
        XCTAssertEqual(editResult.0?.body, "변경된 바디")
    }
}
