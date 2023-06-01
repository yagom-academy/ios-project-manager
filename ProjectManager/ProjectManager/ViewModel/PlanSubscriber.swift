//
//  PlanSubscriber.swift
//  ProjectManager
//
//  Created by 리지 on 2023/05/30.
//

import Combine

protocol PlanSubscriber {
    var plan: [Plan] { get set }
    var deletePublisher: PassthroughSubject<Plan, Never> { get set }
    var changePublisher: PassthroughSubject<(Plan, State), Never> { get set }
    func updatePlan(_ plans: [Plan])
}
