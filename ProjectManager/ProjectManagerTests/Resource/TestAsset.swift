//
//  TestAsset.swift
//  ProjectManagerTests
//
//  Created by duckbok on 2021/08/06.
//

import Foundation
@testable import ProjectManager

enum TestAsset {

    static let dummyTodoResponseTask = ResponseTask(id: UUID(),
                                         title: "나는투두테스트",
                                         body: "성공한다",
                                         dueDate: 164835232,
                                         state: .todo)

    static let dummyDoingResponseTask = ResponseTask(id: UUID(),
                                         title: "나는두잉테스트",
                                         body: "성공한다",
                                         dueDate: 264835132,
                                         state: .todo)

    static let dummyDoneResponseTask = ResponseTask(id: UUID(),
                                         title: "나는돈테스트",
                                         dueDate: 364835132,
                                         state: .todo)

    static let dummyAddedHistory = History(method: .added(title: "난 더해져요"))

    static let dummyRemovedHistory = History(method: .removed(title: "난 삭제돼요", sourceState: .done))

    static let dummyMovedHistory = History(method: .moved(title: "난 움직여요", sourceState: .todo, desinationState: .doing))
}
