//
//  PlanManagerViewModelTests.swift
//  PlanManagerViewModelTests
//
//  Created by 리지 on 2023/05/31.
//

import XCTest
@testable import ProjectManager

final class PlanManagerViewModelTests: XCTestCase {
    var sut: PlanManagerViewModel!
    var planA: Plan?
    var planB: Plan?
    var planC: Plan?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        planA = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        planB = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .todo)
        planC = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .todo)
        
        let todoViewModel = PlanViewModel(state: .todo)
        let doingViewModel = PlanViewModel(state: .doing)
        let doneViewModel = PlanViewModel(state: .done)
        
        sut = PlanManagerViewModel(
            todoViewModel: todoViewModel,
            doingViewModel: doingViewModel,
            doneViewModel: doneViewModel
        )
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_create실행시_planList에값은_nil이아니다() {
        // given
        guard let planA = self.planA,
              let planB = self.planB,
              let planC = self.planC else { return }
        
        sut.create(planA)
        sut.create(planB)
        sut.create(planC)
        
        // when
        let result = sut.planList
        
        // then
        XCTAssertNotNil(result)
    }
    
    func test_update실행시_같은id를가진plan이_업데이트된다() {
        // given
        guard var planB = self.planB else { return }
        sut.create(planB)
        
        let planBID = planB.id
        let planBTitle = planB.title
        let expectationTitle = "NewPlanB"
        let expectationBody = "뉴플랜B"
        let expectationState = State.doing
        
        // when
        let title = "NewPlanB"
        let body = "뉴플랜B"
        let state = State.doing
        
        planB.title = title
        planB.body = body
        planB.state = state
        
        sut.update(planB)
        let newPlanB = sut.planList[0]
        let newPlanBID = newPlanB.id
        
        // then
        XCTAssertEqual(planBID, newPlanBID)
        XCTAssertEqual(planBTitle, "집안일")
        XCTAssertEqual(expectationTitle, newPlanB.title)
        XCTAssertEqual(expectationBody, newPlanB.body)
        XCTAssertEqual(expectationState, newPlanB.state)
    }
}
