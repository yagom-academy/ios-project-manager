//
//  PlanStorageService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

protocol PlanManagable: AnyObject {
    func create(plan: Plan)
    func update(plan: Plan)
}

final class PlanStorageService {
    private var planStore: [Plan]
    
    init(planStore: [Plan]) {
        self.planStore = planStore
    }
    
    func create(plan: Plan) {
        planStore.append(plan)
    }
    
    func fetchPlanList() -> [Plan] {
        return planStore
    }
    
    func update(plan: Plan) {
        guard let index = planStore.firstIndex(where: { $0.id == plan.id }) else { return }
        
        planStore[safe: index] = plan
    }
    
    func deletePlan(id: UUID) {
        guard let index = planStore.firstIndex(where: { $0.id == id }) else { return }
        
        planStore.remove(at: index)
    }
    
    func changeWorkState(planID: UUID, with workState: WorkState) {
        guard let index = planStore.firstIndex(where: { $0.id == planID }) else { return }
        
        planStore[safe: index]?.workState = workState
    }
}
