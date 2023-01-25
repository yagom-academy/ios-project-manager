//
//  CellViewModelTest.swift
//  ProjectManagerTests
//
//  Created by Kyo on 2023/01/18.
//

import XCTest
@testable import ProjectManager

final class CellViewModelTest: XCTestCase {
    var sut: CellViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CellViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_check_DeadLine() {
        sut.setupData(TestData.oldData)
        // output : 마감기한이 지났다면 True
        XCTAssertTrue(sut.checkOverDeadLine())
    }
}
