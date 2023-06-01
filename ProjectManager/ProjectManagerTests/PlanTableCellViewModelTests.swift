//
//  PlanTableCellViewModelTests.swift
//  PlanManagerViewModelTests
//
//  Created by 리지 on 2023/06/01.
//

import XCTest
@testable import ProjectManager

final class PlanTableCellViewModelTests: XCTestCase {
    var sut: PlanTableCellViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let plan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        sut = PlanTableCellViewModel(plan: plan)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_convertDate호출시_Date가String으로변환한다() {
        // given
        let date = Date()
        let expectation = "2023. 06. 01."
        
        // when
        let result = sut.convertDate(of: date)
        
        // then
        XCTAssertEqual(result, expectation)
    }
    
    func test_selectColor호출시_tense가과거면red를_tense가과거가아니면black을반환한다() {
        // given
        let past = Date.distantPast
        let today = Date()
        let future = Date.distantFuture
        
        // when
        let pastResult = sut.selectColor(past)
        let todayResult = sut.selectColor(today)
        let futureResult = sut.selectColor(future)
        
        // then
        XCTAssertEqual(pastResult, TextColor.red)
        XCTAssertEqual(todayResult, TextColor.black)
        XCTAssertEqual(futureResult, TextColor.black)
    }
    
    func test_fetchPlan호출시_plan이반환된다() {
        // given
        let expectationTitle = "산책"
        
        // when
        let result = sut.fetchPlan()
        
        // then
        XCTAssertEqual(result.title, expectationTitle)
    }
}
