//
//  ToDoManagerTests.swift
//  ToDoManagerTests
//
//  Created by 이차민 on 2022/03/02.
//

import XCTest
@testable import ProjectManager

class ToDoManagerTests: XCTestCase {
    var repository: Repository!
    var todoManager: ToDoManager!
    
    override func setUp() {
        repository = ToDoRepository()
        todoManager = ToDoManager(repository: repository)
    }
    
    override func tearDown() {
        repository = nil
        todoManager = nil
    }
    
    func test_Todo_만들고_확인하기() {
        let todo = ToDo(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date().timeIntervalSince1970,
                        state: .waiting)
        todoManager.create(with: todo)
        
        let todos = repository.fetchAll()
        XCTAssertEqual(todos[0].title, "제목")
        XCTAssertEqual(todos[0].description, "본문")
        XCTAssertEqual(todos[0].state, .waiting)
    }
    
    func test_Todo_만들고_삭제하기() {
        let todo = ToDo(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date().timeIntervalSince1970,
                        state: .waiting)
        todoManager.create(with: todo)
        
        todoManager.delete(with: todo)
        let result = todoManager.fetchAll()
        XCTAssertEqual(result.count, 0)
    }
    
    func test_Todo_만들고_제목_변경하기() {
        let todo = ToDo(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date().timeIntervalSince1970,
                        state: .waiting)
        todoManager.create(with: todo)

        let changedTodo = ToDo(id: todo.id,
                           title: "바뀐제목",
                           description: todo.description,
                           deadline: todo.deadline,
                           state: todo.state)
        todoManager.update(with: changedTodo)

        let result = todoManager.fetchAll()
        XCTAssertEqual(result[0].title, "바뀐제목")
    }
    
    func test_Todo_만들고_상태_변경하기() {
        let todo = ToDo(id: UUID(),
                        title: "제목",
                        description: "본문",
                        deadline: Date().timeIntervalSince1970,
                        state: .waiting)
        todoManager.create(with: todo)

        todoManager.changeState(of: todo, to: .done)

        let result = todoManager.fetchAll()
        XCTAssertEqual(result[0].state, .done)
    }
}
