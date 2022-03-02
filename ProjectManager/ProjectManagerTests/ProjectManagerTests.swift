//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 이차민 on 2022/03/02.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    func test_Todo_만들고_확인하기() {
        let repository = ToDoRepository()
        let todoManager = ToDoManager(repository: repository)
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
}
