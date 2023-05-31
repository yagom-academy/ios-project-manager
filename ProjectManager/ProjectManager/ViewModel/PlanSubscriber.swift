//
//  PlanSubscriber.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/30.
//

import Combine

protocol PlanSubscriber {
    func updatePlan(_ plans: [Plan])
    var deletePublisher: PassthroughSubject<Plan, Never> { get set }
    var changePublisher: PassthroughSubject<(Plan, State), Never> { get set }
}
