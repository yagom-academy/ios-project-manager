//
//  TestAsset.swift
//  ProjectManagerTests
//
//  Created by duckbok on 2021/08/06.
//

import Foundation
@testable import ProjectManager

enum TestAsset {

    static let dummyTodoResponseTask: ResponseTask = ResponseTask(id: UUID(), title: "나는투두테스트", body: "성공한다", dueDate: 164835232, state: .todo)

    static let dummyThreeTodoResponseTasks: [ResponseTask] = [
        ResponseTask(id: UUID(), title: "나는투두테스트1", body: "성공한다", dueDate: 164835232, state: .todo),
        ResponseTask(id: UUID(), title: "나는투두테스트2", body: "성공한다22", dueDate: 164835233, state: .todo),
        ResponseTask(id: UUID(), title: "나는투두테스트3", dueDate: 164835234, state: .todo)
    ]

    static let dummyThreeDoingResponseTasks: [ResponseTask] = [
        ResponseTask(id: UUID(), title: "나는두잉테스트1", body: "성공한다", dueDate: 264835132, state: .doing),
        ResponseTask(id: UUID(), title: "나는두잉테스트2", dueDate: 264835133, state: .doing),
        ResponseTask(id: UUID(), title: "나는두잉테스트3", body: "성공한다333", dueDate: 264835134, state: .doing)
    ]

    static let dummyThreeDoneResponseTasks: [ResponseTask] = [
        ResponseTask(id: UUID(), title: "나는돈테스트1", dueDate: 364835132, state: .done),
        ResponseTask(id: UUID(), title: "나는돈테스트2", dueDate: 364835133, state: .done),
        ResponseTask(id: UUID(), title: "나는돈테스트3", dueDate: 364835134, state: .done)
    ]

    static let dummyAddedHistory = History(method: .added(title: "난 더해져요"))

    static let dummyRemovedHistory = History(method: .removed(title: "난 삭제돼요", sourceState: .done))

    static let dummyMovedHistory = History(method: .moved(title: "난 움직여요", sourceState: .todo, desinationState: .doing))
}
