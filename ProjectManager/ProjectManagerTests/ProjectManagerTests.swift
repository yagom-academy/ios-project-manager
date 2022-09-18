//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 수꿍, 휴 on 2022/09/18.
//

@testable import ProjectManager
import XCTest

final class ProjectManagerTests: XCTestCase {
    var sut: ToDoViewModel!
    var sut2: DoingViewModel!
    var countOfToDo: Int?
    var countOfDoing: Int?

    override func setUpWithError() throws {
        try super.setUpWithError()

        sut = ToDoViewModel(databaseManager: MockLocalDatabaseManager())
        sut2 = DoingViewModel(databaseManager: MockLocalDatabaseManager())
        countOfToDo = 0
        countOfDoing = 0

        sut.toDoData.subscribe { [weak self] _ in
            self?.countOfToDo! += 1
        }

        sut2.doingData.subscribe { [weak self] _ in
            self?.countOfDoing! += 1
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        sut = nil
        sut2 = nil
    }

    func test_바인딩하는_클로저가_정상적으로_호출되는지_테스트() {
        // given
        countOfToDo = 0
        let projectUnit = ProjectUnit(
            id: UUID(),
            title: "타이틀",
            body: "바디",
            section: "TODO",
            deadLine: Date()
        )
        let expectation = 1

        // when
        sut.toDoData.value.append(projectUnit)

        // then
        XCTAssertEqual(expectation, countOfToDo)
    }

    func test_viewModel이_projectUnit을_정상적으로_코어데이터에_저장하는지_테스트() {
        // given
        let expectationTitle = "테스트"
        let expectationBody = "테스트를 진행합니다"
        let expectationDate = Date()

        // when
        sut.addProject(title: expectationTitle, body: expectationBody, date: expectationDate)
        let result = sut.fetch(0)

        // then
        XCTAssertEqual(expectationTitle, result?.title)
        XCTAssertEqual(expectationBody, result?.body)
        XCTAssertEqual(expectationDate, result?.deadLine)
    }

    func test_viewModel이_코어데이터에_저장된_projectUnit을_정상적으로_삭제하는지_테스트() {
        // given
        let _ = sut.addProject(title: "타이틀1", body: "바디1", date: Date())
        let _ = sut.addProject(title: "타이틀2", body: "바디2", date: Date())
        let expectation = 1

        // when
        sut.delete(0)
        let result = sut.toDoData.value.count

        // then
        XCTAssertEqual(expectation, result)
    }

    func test_viewModel이_코어데이터에_저장된_projectUnit을_정상적으로_업데이트하는지_테스트() {
        // given
        let _ = sut.addProject(title: "타이틀", body: "바디", date: Date())
        let expectationTitle = "새로운 타이틀"
        let expectationBody = "새로운 바디"
        let expectationDate = Date()

        // when
        sut.edit(indexPath: 0, title: expectationTitle, body: expectationBody, date: expectationDate)
        let result = sut.toDoData.value.first

        // then
        XCTAssertEqual(expectationTitle, result?.title)
        XCTAssertEqual(expectationBody, result?.body)
        XCTAssertEqual(expectationDate, result?.deadLine)
    }

    func test_toDoViewModel의_데이터가_doingViewModel로_정상적으로_이동하는지_테스트() {
        // given
        countOfDoing = 0
        let _ = sut.addProject(title: "타이틀", body: "바디", date: Date())
        let expectation = 1

        // when
        sut.readjust(index: 0, section: "DOING")

        // then
        XCTAssertEqual(expectation, countOfDoing)
    }
}
