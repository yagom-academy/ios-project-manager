//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 수꿍, 휴 on 2022/09/18.
//

@testable import ProjectManager
import XCTest

final class ProjectManagerTests: XCTestCase {
    var toDoSut: ToDoViewModelSpy!
    var doingSut: DoingViewModelSpy!

    override func setUpWithError() throws {
        try super.setUpWithError()

        toDoSut = ToDoViewModelSpy()
        doingSut = DoingViewModelSpy()
        toDoSut.callCountOfData = 0
        doingSut.callCountOfData = 0
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()

        toDoSut = nil
        doingSut = nil
    }

    func test_바인딩하는_클로저가_정상적으로_호출되는지_테스트() {
        // given
        let projectUnit = ProjectUnit(
            id: UUID(),
            title: "타이틀",
            body: "바디",
            section: "TODO",
            deadLine: Date()
        )
        let expectation = 1

        // when
        toDoSut.data.value.append(projectUnit)

        // then
        XCTAssertEqual(expectation, toDoSut.callCountOfData)
    }

    func test_viewModel이_projectUnit을_정상적으로_코어데이터에_저장하는지_테스트() {
        // given
        let expectationCalledCount = 1
        let expectationTitle = "테스트"
        let expectationBody = "테스트를 진행합니다"
        let expectationDate = Date()

        // when
        toDoSut.addContent(title: expectationTitle, body: expectationBody, date: expectationDate)

        // then
        XCTAssertEqual(expectationCalledCount, toDoSut.addContentMethodCalled)
        XCTAssertEqual(expectationTitle, toDoSut.addContentMethodTitleParam)
        XCTAssertEqual(expectationBody, toDoSut.addContentMethodBodyParam)
        XCTAssertEqual(expectationDate, toDoSut.addContentMethodDateParam)
    }

    func test_viewModel이_코어데이터에_저장된_projectUnit을_정상적으로_삭제하는지_테스트() {
        // given
        let expectation = 1
        let expectationCalledCount = 1
        let expectationIndex = 0

        let firstProjectUnit = ProjectUnit(
            id: UUID(),
            title: "타이틀1",
            body: "바디1",
            section: toDoSut.identifier,
            deadLine: Date()
        )
        let secondProjectUnit = ProjectUnit(
            id: UUID(),
            title: "타이틀2",
            body: "바디2",
            section: toDoSut.identifier,
            deadLine: Date()
        )
        toDoSut.data.value = [firstProjectUnit, secondProjectUnit]

        // when
        toDoSut.delete(expectationIndex)

        // then
        XCTAssertEqual(expectation, toDoSut.numberOfData)
        XCTAssertEqual(expectationCalledCount, toDoSut.deleteMethodCalled)
        XCTAssertEqual(expectationIndex, toDoSut.deleteMethodIndexParam)
    }

    func test_viewModel이_코어데이터에_저장된_projectUnit을_정상적으로_업데이트하는지_테스트() {
        // given
        let expectationCallCount = 1
        let expectationIndex = 0
        let expectationTitle = "새로운 타이틀"
        let expectationBody = "새로운 바디"
        let expectationDate = Date()

        let projectUnit = ProjectUnit(
            id: UUID(),
            title: "타이틀1",
            body: "바디1",
            section: toDoSut.identifier,
            deadLine: Date()
        )
        toDoSut.data.value = [projectUnit]

        // when
        toDoSut.edit(
            indexPath: expectationIndex,
            title: expectationTitle,
            body: expectationBody,
            date: expectationDate
        )

        // then
        XCTAssertEqual(expectationCallCount, toDoSut.editMethodCalled)
        XCTAssertEqual(expectationIndex, toDoSut.editMethodIndexParam)
        XCTAssertEqual(expectationTitle, toDoSut.editMethodTitleParam)
        XCTAssertEqual(expectationBody, toDoSut.editMethodBodyParam)
        XCTAssertEqual(expectationDate, toDoSut.editMethodDateParam)
    }

    func test_toDoViewModel의_데이터가_doingViewModel로_정상적으로_이동하는지_테스트() {
        // given
        let expectationCallCount = 1
        let expectationIndex = 0
        let expectationStatus = doingSut.identifier
        let expectationTitle = "새로운 타이틀"
        let expectationBody = "새로운 바디"
        let expectationDate = Date()

        let projectUnit = ProjectUnit(
            id: UUID(),
            title: expectationTitle,
            body: expectationBody,
            section: toDoSut.identifier,
            deadLine: expectationDate
        )
        toDoSut.data.value = [projectUnit]

        // when
        toDoSut.change(index: expectationIndex, status: expectationStatus)
        let result = doingSut.data.value[expectationIndex]

        // then
        XCTAssertEqual(expectationCallCount, toDoSut.changeMethodCalled)
        XCTAssertEqual(expectationIndex, toDoSut.changeMethodIndexParam)
        XCTAssertEqual(expectationStatus, toDoSut.changeMethodStatusParam)
        XCTAssertEqual(expectationTitle, result.title)
        XCTAssertEqual(expectationBody, result.body)
        XCTAssertEqual(expectationDate, result.deadLine)
    }
}
