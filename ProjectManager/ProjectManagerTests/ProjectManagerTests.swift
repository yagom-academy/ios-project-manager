//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 예거 on 2022/03/03.
//

import XCTest
@testable import ProjectManager

class ProjectManagerTests: XCTestCase {
    
    var taskManager: TaskManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        taskManager = TaskManager()
        taskManager.createTask(title: "0번 할일", body: "할일 내용0", dueDate: Date())
        taskManager.createTask(title: "1번 할일", body: "할일 내용1", dueDate: Date())
        taskManager.createTask(title: "2번 할일", body: "할일 내용2", dueDate: Date())
        taskManager.createTask(title: "3번 할일", body: "할일 내용3", dueDate: Date())
        taskManager.createTask(title: "4번 할일", body: "할일 내용4", dueDate: Date())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        taskManager = nil
    }

    func test_Task_인스턴스_5개_생성_검증() {
        let result = taskManager.todoTasks.count
        XCTAssertEqual(result, 5)
    }
    
    func test_Task_status_변경_검증() {
        let doingTarget = taskManager.todoTasks.first!
        let doneTarget = taskManager.todoTasks.last!
        taskManager.changeTaskStatus(target: doingTarget, to: .doing)
        taskManager.changeTaskStatus(target: doneTarget, to: .done)
        XCTAssertTrue(taskManager.doingTasks.first! == doingTarget)
        XCTAssertTrue(taskManager.doneTasks.first! == doneTarget)
    }
    
    func test_Task_수정_검증() {
        let target = taskManager.todoTasks.first!
        taskManager.modifyTask(target: target, title: "제목 변경", body: "내용 변경", dueDate: Date(timeIntervalSince1970: 1646289747.609154))
        XCTAssertEqual(target.title, "제목 변경")
        XCTAssertEqual(target.body, "내용 변경")
        XCTAssertEqual(target.dueDate, Date(timeIntervalSince1970: 1646289747.609154))
    }

    func test_Task_status_변경_후_삭제_검증() {
        taskManager.changeTaskStatus(target: taskManager.todoTasks.last!, to: .done)
        let target = taskManager.doneTasks.first!
        taskManager.deleteTask(target: target)
        XCTAssertTrue(taskManager.doneTasks.isEmpty)
    }
    
    func test_Task_생성_후_dueDate_정렬_검증() {
        taskManager.createTask(title: "오래된 할일", body: "1991년 11월 6일에 저장한 할일", dueDate: Date(timeIntervalSince1970: 689400000))
        let target = taskManager.todoTasks.first!
        XCTAssertTrue(target.dueDate == Date(timeIntervalSince1970: 689400000))
    }
}
