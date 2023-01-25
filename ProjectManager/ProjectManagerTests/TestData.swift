//
//  TestData.swift
//  ProjectManagerTests
//
//  Created by Kyo on 2023/01/18.
//

import Foundation
@testable import ProjectManager

enum TestData {
    static let data1 = Plan(
        title: "1번 Test Data",
        content: "이것은 1번 TestData Content 입니다.",
        deadLine: Date()
    )

    static let data2 = Plan(
        title: "2번 Test Data",
        content: "이것은 2번 TestData Content 입니다.",
        deadLine: Date()
    )

    static let oldData = Plan(
        title: "오래된 Test Data",
        content: "이것은 오래된 TestData Content 입니다.",
        deadLine: Date(timeIntervalSince1970: 10000)
    )
}
