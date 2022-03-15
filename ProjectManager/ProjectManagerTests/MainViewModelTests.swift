//
//  ProjectManagerTests.swift
//  ProjectManagerTests
//
//  Created by 이승재 on 2022/03/08.
//

import XCTest

class MainViewModelTests: XCTestCase {

    private var sut: MainViewModel!

    override func setUpWithError() throws {
        let dataSource = MockData.dataSource()
        let repository = DataRepository(dataSource: dataSource)
        let useCase = ScheduleUseCase(repository: repository)
        self.sut = MainViewModel(useCase: useCase)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_whenFetch() throws {
        self.sut.fetch()

        XCTAssertEqual(sut.scheduleList.value, MockData.schedules)
    }

    func test_whenDelete() throws {
        self.sut.fetch()
        self.sut.delete(scheduleID: MockData.schedules.first!.id)
        let deleted = Array(MockData.schedules[1...(MockData.schedules.count - 1)])

        XCTAssertEqual(sut.scheduleList.value, deleted)
    }
}

extension Schedule: Equatable {
    static func == (lhs: Schedule, rhs: Schedule) -> Bool {
        lhs.id == rhs.id
    }
}
