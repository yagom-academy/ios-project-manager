//
//  TestDouble.swift
//  TestDouble
//
//  Created by brad, bard on 2022/09/19.
//

import XCTest
@testable import ProjectManager

class TestDouble: XCTestCase {
    
    var sut: ToDoViewModel?
    var todoList = [ToDoItem(title: "Test", description: "test", timeLimit: Date()),
                    ToDoItem(title: "Test1", description: "test1", timeLimit: Date()),
                    ToDoItem(title: "Test2", description: "test2", timeLimit: Date())]
  
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ToDoViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_ToDoViewModel의_ToDo프로젝트타입에_아이템을추가하면_해당프로젝트타입에대한_아이템개수를_잘세는지() {
        // given
        sut?.append(new: todoList[0], to: .todo)
            
        // when
        let result = 1
        
        // then
        XCTAssertEqual(sut?.count(of: .todo), result)
    }
    
    func test_todoList에_ToDoItem들을추가해주고_배열의두번째값을삭제했을때_잘삭제가되었는가() {
        // given
        sut?.append(new: todoList[0], to: .todo)
        sut?.append(new: todoList[1], to: .todo)
        sut?.append(new: todoList[2], to: .todo)
        
        // when
        let index = 1
        sut?.delete(from: index, of: .todo)
        let result = todoList[index]
        
        // then
        XCTAssertNotEqual(sut?.searchContent(from: index, of: .todo), result)
    }
}
