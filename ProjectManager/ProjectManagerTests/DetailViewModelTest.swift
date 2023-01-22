//
//  DetailViewModelTest.swift
//  ProjectManagerTests
//
//  Created by Kyo on 2023/01/18.
//

import XCTest
@testable import ProjectManager

final class DetailViewModelTest: XCTestCase {
    var sut: DetailViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DetailViewModel(data: nil)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_data를_신규추가할때_Mode가_new인지_check() {
        XCTAssertTrue(sut.isNewMode())
    }

    func test_data를_변경할때_Mode가_edit인지_check() {
        sut = DetailViewModel(data: TestData.data1)
        XCTAssertFalse(sut.isNewMode())
    }

    func test_data를_신규추가할때_Edit이_가능한지_check() {
        XCTAssertTrue(sut.isEdiatable)
    }

    func test_data를_변경할때_Edit이_가능한지_check() {
        sut = DetailViewModel(data: TestData.data1)
        XCTAssertFalse(sut.isEdiatable)
    }
}
