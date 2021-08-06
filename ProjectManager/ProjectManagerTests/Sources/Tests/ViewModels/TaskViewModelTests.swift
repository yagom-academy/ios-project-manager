//
//  TaskViewModelTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

private final class TaskViewModelTests: XCTestCase {

    var sutTaskViewModel: TaskViewModel!
    var mockCoreDataStack: CoreDataStackProtocol!

    var addedIndex: Int!
    var isChanged: Bool!
    var insertedStateAndIndex: (state: Task.State, index: Int)!
    var removedStateAndIndex: (state: Task.State, index: Int)!

    // TODO: SpyTaskRepository 이니셜라이저 변경
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCoreDataStack = MockCoreDataStack()
        sutTaskViewModel = TaskViewModel(networkRepository: SpyNetworkRepository(), coreDataStack: mockCoreDataStack)

        sutTaskViewModel.added = { (index) in
            self.addedIndex = index
        }
        sutTaskViewModel.changed = {
            self.isChanged = true
        }
        sutTaskViewModel.inserted = { (state, index) in
            self.insertedStateAndIndex = (state, index)
        }
        sutTaskViewModel.removed = { (state, index) in
            self.removedStateAndIndex = (state, index)
        }

        isChanged = false
    }

    override func tearDownWithError() throws {
        sutTaskViewModel = nil
        mockCoreDataStack = nil
        addedIndex = nil
        isChanged = nil
        insertedStateAndIndex = nil
        removedStateAndIndex = nil
        try super.tearDownWithError()
    }

    func test_task를_todo에_추가한다() throws {
//        let task: Task = Task(context: mockCoreDataStack.context)

//        try mockCoreDataStack.context.save()
//        sutTaskViewModel.add()
    }

    func test_state와index를통해_해당task를반환한다() {

//        sutTaskViewModel.task(from: ., at: <#T##Int#>)
    }
}
