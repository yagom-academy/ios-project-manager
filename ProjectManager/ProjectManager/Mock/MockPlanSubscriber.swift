//
//  MockPlanSubscriber.swift
//  ProjectManager
//
//  Created by 리지 on 2023/06/01.
//

import Foundation
import Combine

final class MockPlanSubscriber: PlanSubscriber {
    var plans: [Plan]?
    var deletePublisher = PassthroughSubject<Plan, Never>()
    var changePublisher = PassthroughSubject<(Plan, State), Never>()

    func updatePlan(_ plans: [Plan]) {
        self.plans = plans
    }
}
