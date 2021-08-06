//
//  CoreDataRepositoryTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
import CoreData
@testable import ProjectManager

final class CoreDataRepositoryTests: XCTestCase {

    private var sutCoreDataRepository: CoreDataRepository!
    private var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sutCoreDataRepository = CoreDataRepository(coreDataStack: MockCoreDataStack())
        context = sutCoreDataRepository.coreDataStack.context
    }
    
    override func tearDownWithError() throws {
        context = nil
        sutCoreDataRepository = nil
        try super.tearDownWithError()
    }
    
    func test_context에save하면_task가저장된다() throws {
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        let task = Task(context: context, responseTask: TestAsset.dummyTodoResponseTask)
        sutCoreDataRepository.coreDataStack.saveContext()
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error, "Save did not occur")
        }
        
        XCTAssertEqual(sutCoreDataRepository.coreDataStack.fetchTasks().count, 1)
        XCTAssertEqual(try context.existingObject(with: task.objectID), task)
        XCTAssertFalse(sutCoreDataRepository.isEmpty)
    }

    func test_task메서드에objectID를전달하면_저장된task를반환한다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .doing)
        
        let taskFoundFromContextByObjectID = sutCoreDataRepository.task(with: task.objectID)
        XCTAssertEqual(taskFoundFromContextByObjectID, task)
        XCTAssertEqual(taskFoundFromContextByObjectID?.id, task.id)
        XCTAssertEqual(taskFoundFromContextByObjectID?.title, task.title)
        XCTAssertEqual(taskFoundFromContextByObjectID?.body, task.body)
        XCTAssertEqual(taskFoundFromContextByObjectID?.dueDate, task.dueDate)
        XCTAssertEqual(taskFoundFromContextByObjectID?.taskState, task.taskState)
    }

    func test_context에task가없으면_isEmpty는true를반환한다() {
        XCTAssertEqual(sutCoreDataRepository.coreDataStack.fetchTasks().count, .zero)

        XCTAssertTrue(sutCoreDataRepository.isEmpty)
    }

    func test_context에task가있으면_isEmpty는false를반환한다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .doing)
        
        let fetchedTasks = sutCoreDataRepository.coreDataStack.fetchTasks()
        XCTAssertEqual(fetchedTasks.count, 1)
        XCTAssertEqual(try sutCoreDataRepository.coreDataStack.context.existingObject(with: task.objectID), task)
        XCTAssertFalse(sutCoreDataRepository.isEmpty)
    }

    func test_create를호출하면_task가context에생성되고저장된다() throws {
        let context = sutCoreDataRepository.coreDataStack.context

        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .doing)
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error, "Save did not occur")
        }

        XCTAssertEqual(context.registeredObjects.count, 1)
        XCTAssertEqual(try context.existingObject(with: task.objectID), task)
    }

    func test_read를호출하면_저장된taskList배열을반환한다() throws {
        let todoTask = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)
        let doingTask = try sutCoreDataRepository.create(title: "가나다", body: "이히잇", dueDate: Date(), state: .doing)
        let doneTask = try sutCoreDataRepository.create(title: "하이용", body: "옹헤야", dueDate: Date(), state: .done)
        
        let taskList = sutCoreDataRepository.read()
        XCTAssertEqual(taskList[.todo].count, 1)
        XCTAssertEqual(taskList[.doing].count, 1)
        XCTAssertEqual(taskList[.done].count, 1)
        XCTAssertEqual(taskList[.todo].first, todoTask)
        XCTAssertEqual(taskList[.doing].first, doingTask)
        XCTAssertEqual(taskList[.done].first, doneTask)
    }
    
    func test_update에objectID와수정할내용을전달하면_task를수정할수있다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)

        let expectedTitle: String = "Updated"
        let expectedDueDate: Date? = Date().date
        let expectedBody: String = "Update test"
        let expectedState: Task.State = .doing
        sutCoreDataRepository.update(objectID: task.objectID,
                              title: expectedTitle,
                              dueDate: expectedDueDate,
                              body: expectedBody,
                              state: expectedState)

        let updatedTask = sutCoreDataRepository.task(with: task.objectID)
        XCTAssertEqual(updatedTask?.id, task.id)
        XCTAssertEqual(updatedTask?.title, expectedTitle)
        XCTAssertEqual(updatedTask?.body, expectedBody)
        XCTAssertEqual(updatedTask?.dueDate, expectedDueDate)
        XCTAssertEqual(updatedTask?.taskState, expectedState)
    }
    
    func test_softDelete에objectID를전달하면_isRemoved가true로변경된다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)

        sutCoreDataRepository.softDelete(task.objectID)

        let softDeletedTask = sutCoreDataRepository.task(with: task.objectID)
        XCTAssertEqual(softDeletedTask?.isRemoved, true)
    }
    
    func test_delete에objectID를전달하면_task가context에서삭제된다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)

        sutCoreDataRepository.delete(task.objectID)

        XCTAssertEqual(sutCoreDataRepository.isEmpty, true)
        XCTAssertNil(sutCoreDataRepository.task(with: task.objectID))
    }
    
    func test_insertFromPendingTaskList에task를전달하면_네트워크작업이미완료된task가pendingTaskList에추가된다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)
        
        sutCoreDataRepository.insertFromPendingTaskList(task)
        let pendingTasks = sutCoreDataRepository.readPendingTasks()
        XCTAssertEqual(pendingTasks?.count, 1)
        XCTAssertEqual(pendingTasks?.first, task)
    }
    
    func test_deleteFromPendingTaskList에task를전달하면_네트워크작업이완료된task가pendingTaskList에서제거된다() throws {
        let task = try sutCoreDataRepository.create(title: "ABC", body: "123", dueDate: Date(), state: .todo)
        sutCoreDataRepository.insertFromPendingTaskList(task)
        
        sutCoreDataRepository.deleteFromPendingTaskList(task)
        let pendingTasks = sutCoreDataRepository.readPendingTasks()
        XCTAssertEqual(pendingTasks?.count, .zero)
        XCTAssertEqual(pendingTasks?.first, nil)
    }
}
