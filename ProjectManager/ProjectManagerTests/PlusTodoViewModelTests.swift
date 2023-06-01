//
//  PlusTodoViewModelTests.swift
//  PlanManagerViewModelTests
//
//  Created by 리지 on 2023/06/01.
//

import XCTest
@testable import ProjectManager

final class PlusTodoViewModelTests: XCTestCase {
    var sut: PlusTodoViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        sut = PlusTodoViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_addPlan호출시_현재plan은_nil이아니다() {
        // given
        let plan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        
        // when
        sut.addPlan(plan)
        
        // then
        XCTAssertNotNil(sut.currentPlan)
    }
    
    func test_configureInitialPlan호출시_입력된Plan이반환된다() {
        // given
        let title = "산책"
        let body = "강아지 산책시키기"
        let date = Date()
        let expectation = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        
        // when
        let result = sut.configureInitialPlan(title: title, body: body, date: date)
        
        // then
        XCTAssertEqual(result.title, expectation.title)
        XCTAssertEqual(result.body, expectation.body)
        XCTAssertEqual(result.date, expectation.date)
        XCTAssertEqual(result.state, expectation.state)
    }
    
    func test_updateCurrentPlan호출시_isEdit이참이면_plan값이업데이트된다() {
        // given
        let title = "TIL작성"
        let body = "오늘 학습활동 정리하기"
        let date = Date()
        let plan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        sut.addPlan(plan)
        sut.changEditMode()
        
        // when
        guard let result = sut.updateCurrentPlan(title: title, body: body, date: date) else { return }
        
        // then
        XCTAssertEqual(result.title, title)
        XCTAssertEqual(result.body, body)
        XCTAssertEqual(result.date, date)
    }
    
    func test_fetchCurrentPlan호출시_currentPlan을반환한다() {
        // given
        let plan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        sut.addPlan(plan)
        
        // when
        guard let result = sut.fetchCurrentPlan() else { return }
        
        // then
        XCTAssertEqual(result.title, plan.title)
        XCTAssertEqual(result.body, plan.body)
        XCTAssertEqual(result.date, plan.date)
    }
}
