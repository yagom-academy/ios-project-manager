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
    var mockTodoPlanSubscriber: MockPlanSubscriber!
    var mockDoingPlanSubscriber: MockPlanSubscriber!
    var mockDonePlanSubscriber: MockPlanSubscriber!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        mockTodoPlanSubscriber = MockPlanSubscriber()
        mockDoingPlanSubscriber = MockPlanSubscriber()
        mockDonePlanSubscriber = MockPlanSubscriber()
        
        sut = PlanManagerViewModel(
            todoViewModel: mockTodoPlanSubscriber,
            doingViewModel: mockDoingPlanSubscriber,
            doneViewModel: mockDonePlanSubscriber
        )
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        sut = nil
    }
    
    func test_create실행시_planList에값은_nil이아니다() {
        // given
        let planA = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let planB = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .todo)
        let planC = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .todo)
        
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
        var planB = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .todo)
        
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
    
    func test_mockPlanSubscriber의_deletePublisher에값이들어오면_planList배열에서삭제된다() {
        // given
        let todoPlan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let doingPlan = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .doing)
        let donePlan = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .done)
        
        sut.create(todoPlan)
        sut.create(doingPlan)
        sut.create(donePlan)
        let oldPlans = sut.planList
        
        mockTodoPlanSubscriber.deletePublisher.send(todoPlan)
        mockDoingPlanSubscriber.deletePublisher.send(doingPlan)
        mockDonePlanSubscriber.deletePublisher.send(donePlan)
        
        // when
        let newPlans = sut.planList
        
        // then
        XCTAssertNotEqual(oldPlans, newPlans)
    }
    
    func test_mockPlanSubscriber의_changePublisher에값이들어오면_plan의상태가_새로운값으로변경된다() {
        // given
        let todoPlan = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let doingPlan = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .doing)
        let donePlan = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .done)
        
        sut.create(todoPlan)
        sut.create(doingPlan)
        sut.create(donePlan)
        
        mockTodoPlanSubscriber.changePublisher.send((todoPlan, .doing))
        mockDoingPlanSubscriber.changePublisher.send((doingPlan, .done))
        mockDonePlanSubscriber.changePublisher.send((donePlan, .todo))
        
        // when
        let newPlans = sut.planList
        let newTodoPlan = newPlans[0]
        let newDoingPlan = newPlans[1]
        let newDonePlan = newPlans[2]
        
        // then
        XCTAssertEqual(newTodoPlan.state, .doing)
        XCTAssertEqual(newDoingPlan.state, .done)
        XCTAssertEqual(newDonePlan.state, .todo)
    }
}
