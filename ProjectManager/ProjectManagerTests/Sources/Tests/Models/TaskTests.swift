//
//  TaskTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
import MobileCoreServices
@testable import ProjectManager

final class TaskTests: XCTestCase {

    private var coreDataRepository: CoreDataRepository!
    private var sutTask: Task!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataRepository = CoreDataRepository(coreDataStack: MockCoreDataStack())
        guard let today = Calendar.current.date(byAdding: .day, value: 0, to: Date()) else {
            XCTFail("날짜를 가져오지 못했습니다.")
            return
        }
        sutTask = try coreDataRepository.create(title: "ABC", body: "123", dueDate: today, state: .todo)
    }

    override func tearDownWithError() throws {
        sutTask = nil
        coreDataRepository = nil
        try super.tearDownWithError()
    }

    func test_dueDate가현재날짜보다미래라면_isExpired는false를반환한다() {
        guard let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: sutTask.dueDate) else {
            XCTFail("날짜를 가져오지 못했습니다.")
            return
        }
        sutTask.dueDate = futureDate

        XCTAssertEqual(sutTask.isExpired, false)
    }

    func test_dueDate가현재날짜보다과거라면_isExpired는true를반환한다() throws {
        guard let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: sutTask.dueDate) else {
            XCTFail("날짜를 가져오지 못했습니다.")
            return
        }
        sutTask.dueDate = pastDate

        print("요기용",sutTask.dueDate, Date())
        
        XCTAssertEqual(sutTask.isExpired, true)
    }

    func test_taskState를호출하면_State타입의state를반환한다() {
        XCTAssertEqual(sutTask.state, "todo")
        XCTAssertEqual(sutTask.taskState, .todo)
    }

    func test_taskState를통해_State타입으로state를변경할수있다() {
        sutTask.taskState = .doing

        XCTAssertEqual(sutTask.taskState, .doing)
        XCTAssertEqual(sutTask.state, "doing")
    }

    func test_drag시호출된loadData는_성공시json형식으로인코딩된task를completion으로전달한다() throws {
        let encodedTask = try JSONEncoder().encode(sutTask)
        guard let typeIdentifier = Task.writableTypeIdentifiersForItemProvider.first else {
            XCTFail("지정된 type identifier가 없습니다.")
            return
        }

        _ = sutTask.loadData(withTypeIdentifier: typeIdentifier) { data, error in
            XCTAssertEqual(encodedTask, data)
            XCTAssertNil(error)
        }
    }
    
    func test_loadData에유효하지않은typeIdentifier를전달하면_invalidTypeIdentifier에러를completion으로전달한다() throws {
        let invalidTypeIdentifier = kUTTypePlainText as String
        
        _ = sutTask.loadData(withTypeIdentifier: invalidTypeIdentifier) { data, error in
            XCTAssertNil(data)
            XCTAssertEqual(error as? PMError, PMError.invalidTypeIdentifier)
        }
    }

    func test_drop시호출된object는_성공시디코딩된task를반환한다() throws {
        let encodedTask = try JSONEncoder().encode(sutTask)
        guard let typeIdentifier = Task.writableTypeIdentifiersForItemProvider.first else {
            XCTFail("지정된 type identifier가 없습니다.")
            return
        }

        let droppedTask = try Task.object(withItemProviderData: encodedTask, typeIdentifier: typeIdentifier)
        XCTAssertEqual(droppedTask.id, sutTask.id)
        XCTAssertEqual(droppedTask.title, sutTask.title)
        XCTAssertEqual(droppedTask.body, sutTask.body)
        XCTAssertEqual(droppedTask.dueDate, sutTask.dueDate)
        XCTAssertEqual(droppedTask.taskState, sutTask.taskState)
    }
}

extension PMError: Equatable {

    public static func == (lhs: PMError, rhs: PMError) -> Bool {
        return lhs.description == rhs.description
    }
}
