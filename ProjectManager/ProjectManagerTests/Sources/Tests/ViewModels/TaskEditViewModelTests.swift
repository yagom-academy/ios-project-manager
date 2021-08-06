//
//  TaskEditViewModelTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class TaskEditViewModelTests: XCTestCase {

    var sutTaskEditViewModel: TaskEditViewModel!
    var mockCoreDataStack: CoreDataStackProtocol!
    var coreDataRepository: CoreDataRepository!

    var updatedTaskAndIndexPath: (indexPath: IndexPath, task: Task)!
    var createdTask: Task!

    var dummyTask: Task!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCoreDataStack = MockCoreDataStack()
        sutTaskEditViewModel = TaskEditViewModel(coreDataStack: mockCoreDataStack)
        coreDataRepository = CoreDataRepository(coreDataStack: mockCoreDataStack)

        sutTaskEditViewModel.updated = { [weak self] (indexPath, task) in
            self?.updatedTaskAndIndexPath = (indexPath, task)
        }
        sutTaskEditViewModel.created = { [weak self] (task) in
            self?.createdTask = task
        }

        dummyTask = try coreDataRepository.create(title: "테스트를 하자", body: "본문입니다", dueDate: Date(), state: .todo)
    }

    override func tearDownWithError() throws {
        sutTaskEditViewModel = nil
        mockCoreDataStack = nil
        coreDataRepository = nil
        updatedTaskAndIndexPath = nil
        createdTask = nil
        dummyTask = nil
        try super.tearDownWithError()
    }

    func test_update시에_task나indexPath가없다면_동작하지않는다() throws {
        sutTaskEditViewModel.update(title: "업데이트됨", dueDate: Date(), body: "본문이에요")

        XCTAssertNil(updatedTaskAndIndexPath)
    }

    func test_update시에_변한값이없다면_동작하지않는다() throws {
        sutTaskEditViewModel.setTask(dummyTask, indexPath: IndexPath(row: 0, section: 0))

        sutTaskEditViewModel.update(title: dummyTask.title, dueDate: dummyTask.dueDate, body: dummyTask.body!)

        XCTAssertNil(updatedTaskAndIndexPath)
    }

    func test_update를호출하면_해당task과indexPath를updated로넘겨준다() {
        sutTaskEditViewModel.setTask(dummyTask, indexPath: IndexPath(row: 0, section: 0))

        sutTaskEditViewModel.update(title: "업데이트됨", dueDate: Date(), body: "")

        XCTAssertEqual(updatedTaskAndIndexPath?.indexPath, sutTaskEditViewModel.indexPath)
        XCTAssertEqual(updatedTaskAndIndexPath?.task, sutTaskEditViewModel.task)
    }

    func test_빈body로_create를호출하면_해당task를프로퍼티로저장하고created로넘겨준다() {
        sutTaskEditViewModel.create(title: "아무튼 생성됨", dueDate: Date(), body: "")

        XCTAssertNil(sutTaskEditViewModel.task!.body)
        XCTAssertEqual(createdTask, sutTaskEditViewModel.task)
    }

    func test_내용있는body로_create를호출하면_해당task를프로퍼티로저장하고created로넘겨준다() {
        sutTaskEditViewModel.create(title: "아무튼 생성됨", dueDate: Date(), body: "내용왜용")

        XCTAssertNotNil(sutTaskEditViewModel.task!.body)
        XCTAssertEqual(createdTask, sutTaskEditViewModel.task)
    }
}
