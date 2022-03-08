//
//  MockDataSource.swift
//  ProjectManagerTests
//
//  Created by 이승재 on 2022/03/08.
//

import Foundation

class MockData {

    static let schedules: [Schedule] = [
        Schedule(title: "1번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
        Schedule(title: "2번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
        Schedule(title: "3번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
        Schedule(title: "4번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
        Schedule(title: "5번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing)
    ]

    static func dataSource() -> DataSource {
        let dataSource = MemoryDataSource()
        dataSource.storage = schedules

        return dataSource
    }
}
