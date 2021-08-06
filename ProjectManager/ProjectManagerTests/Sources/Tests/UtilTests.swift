//
//  UtilTests.swift
//  ProjectManagerTests
//
//  Created by duckbok, Ryan-Son on 2021/08/04.
//

import XCTest
@testable import ProjectManager

final class UtilTests: XCTestCase {

    var sutDate: Date!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sutDate = Date(timeIntervalSince1970: 0)
    }

    override func tearDownWithError() throws {
        sutDate = nil
        try super.tearDownWithError()
    }

    func test_date인스턴스를_taskFormat으로연산하면_현재국가기준으로짧은문자열로반환한다() {
        let expected: String = "Jan 1, 1970"

        XCTAssertEqual(sutDate.taskFormat, expected)
    }

    func test_date인스턴스를_historyFormat으로연산하면_현재국가기준으로긴문자열로반환한다() {
        let expected: String = "January 1, 1970 at 9:00:00 AM"

        XCTAssertEqual(sutDate.historyFormat, expected)
    }

    func test_date인스턴스를_date으로연산하면_현재국가기준으로시간값을빼서반환한다() {
        let expected: String = "1969-12-31 15:00:00 +0000"

        XCTAssertEqual(sutDate.date!.description, expected)
    }
}
