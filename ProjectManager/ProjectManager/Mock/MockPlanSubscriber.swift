//
//  MockPlanSubscriber.swift
//  ProjectManager
//
//  Created by 리지 on 2023/06/01.
//

import Foundation
import Combine

final class MockPlanSubscriber: PlanSubscriber {
    var plan: [Plan]
    var deletePublisher = PassthroughSubject<Plan, Never>()
    var changePublisher = PassthroughSubject<(Plan, State), Never>()

    init(plan: [Plan]) {
        self.plan = plan
    }
    
    func updatePlan(_ plan: [Plan]) {
        self.plan = plan
    }
}
