//
//  TranslaterTests.swift
//  TranslaterTests
//
//  Created by ayaan, jpush on 2023/01/17.
//

import XCTest

final class TranslaterTests: XCTestCase {
    func test_task_convert_to_taskEntity_success() {
        // given
        let tasks = TaskDummy.dummys
        let translater = Translater()
        
        // when, then
        tasks.forEach { task in
            XCTAssertNotNil(translater.toEntity(with: task))
        }
    }
    
    func test_taskEntity_convert_to_task_success() {
        // given
        let tasks = TaskEntityDummy.dummys
        let translater = Translater()
        
        // when, then
        tasks.forEach { task in
            XCTAssertNotNil(translater.toDomain(with: task))
        }
    }
    
    func test_wrong_state_taskEntity_convert_to_task_failure() {
        // given
        let task = TaskEntity(
            id: UUID().uuidString,
            title: "제목",
            content: "내용",
            deadLine: 1674140400,
            state: 4
        )
        let translater = Translater()
        
        // when, then
        XCTAssertNil(translater.toDomain(with: task))
    }
}
