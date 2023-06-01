//
//  PlanViewModelTests.swift
//  PlanManagerViewModelTests
//
//  Created by 리지 on 2023/05/31.
//

import Combine
import XCTest
@testable import ProjectManager

final class PlanViewModelTests: XCTestCase {
    var sut: PlanViewModel!
    var mockSubscriber: MockPlanSubscriber!
    var cancellabels = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = PlanViewModel(state: .todo)
        mockSubscriber = MockPlanSubscriber()
        
        let planA = Plan(title: "산책", body: "강아지 산책시키기", date: Date(), state: .todo)
        let planB = Plan(title: "집안일", body: "설거지, 빨래, 청소기돌리기", date: Date(), state: .todo)
        let planC = Plan(title: "공부", body: "MVC, MVP, MVVM 패턴 공부하기", date: Date(), state: .todo)
        
        sut.plan = [planA, planB, planC]
        sut.deletePublisher = mockSubscriber.deletePublisher
        sut.changePublisher = mockSubscriber.changePublisher
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        cancellabels.forEach { $0.cancel() }
    }
    
    func test_state가todo일때_firstActionTitle은_doing이고_secondActionTitle은_done이다 () {
        // given
        let firstExpectation = "Move to DOING"
        let secondExpectation = "Move to DONE"
        
        // when
        let firstResult = sut.firstActionTitle
        let secondResult = sut.secondActionTitle
        
        // then
        XCTAssertEqual(firstExpectation, firstResult)
        XCTAssertEqual(secondExpectation, secondResult)
    }
    
    func test_state가todo일때_첫번째변경상태는doing이고_두번째변경상태는done이다() {
        // given
        let firstState = State.doing
        let secondState = State.done
        
        // when
        let firstResult = sut.moveToFirst
        let secondResult = sut.moveToSecond
        
        // then
        XCTAssertEqual(firstState, firstResult)
        XCTAssertEqual(secondState, secondResult)
    }
    
    func test_numberOfItems실행시_plan배열의count를반환한다() {
        // given
        let expectation = 3
        
        // when
        let result = sut.numberOfItems
        
        // then
        XCTAssertEqual(expectation, result)
    }
    
    func test_updatePlan실행시_기존plan이_새로운plan으로_업데이트된다() {
        // given
        let newPlanA = Plan(title: "운동", body: "필라테스1시간", date: Date(), state: .doing)
        let newPlanB = Plan(title: "코드리팩토링", body: "다이어리,계산기앱 리팩토링하기", date: Date(), state: .done)
        let newPlans: [Plan] = [newPlanA, newPlanB]
        
        // when
        sut.updatePlan(newPlans)
        let result = sut.plan
        
        // then
        XCTAssertEqual(newPlans, result)
    }
    
    func test_read실행시_indexPath로접근하여_plan을꺼내온다() {
        // given
        let indexPath = IndexPath(row: 1, section: 0)
        let expectationTitle = "집안일"
        let expectationState = State.todo
        
        // when
        let result = sut.read(at: indexPath)
        
        // then
        XCTAssertEqual(expectationTitle, result.title)
        XCTAssertEqual(expectationState, result.state)
    }
    
    func test_delete실행시_deletPublisher에값이전달된다() {
        // given
        let indexPath = IndexPath(row: 1, section: 0)
        let planToDelete = sut.read(at: indexPath)
        let expectation = expectation(description: "delete")
        
        mockSubscriber.deletePublisher
            .sink { plan in
                XCTAssertEqual(plan, planToDelete)
                expectation.fulfill()
            }
            .store(in: &cancellabels)
        
        // when
        sut.delete(planToDelete)
        
        // then
        waitForExpectations(timeout: 1)
    }
    
    func test_changeState실행시_changePublisher에값이전달된다() {
        // given
        let indexPath = IndexPath(row: 1, section: 0)
        let planToChange = sut.read(at: indexPath)
        let newState = State.doing
        let expectation = expectation(description: "change")
        
        mockSubscriber.changePublisher
            .sink { plan, state in
                XCTAssertEqual(plan, planToChange)
                XCTAssertEqual(state, newState)
                expectation.fulfill()
            }
            .store(in: &cancellabels)
        
        // when
        sut.changeState(plan: planToChange, state: newState)
        
        // then
        waitForExpectations(timeout: 1)
    }

}
