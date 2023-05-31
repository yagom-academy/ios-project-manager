//
//  MainCollectionViewService.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/23.
//

import Foundation

final class planStorageService {
    private var planStore: [Plan]
    
    init(planStore: [Plan]) {
        self.planStore = planStore
    }
    
    func createplan(_ plan: Plan) {
        planStore.append(plan)
    }
    
    func fetchplanList() -> [Plan] {
        return planStore
    }
    
    func updateplan(_ plan: Plan) {
        guard let index = planStore.firstIndex(where: { $0.id == plan.id }) else { return }
        
        planStore[safe: index] = plan
    }
    
    func deleteplan(id: UUID) {
        guard let index = planStore.firstIndex(where: { $0.id == id }) else { return }
        
        planStore.remove(at: index)
    }
    
    func changeWorkState(planID: UUID, with workState: WorkState) {
        guard let index = planStore.firstIndex(where: { $0.id == planID }) else { return }
        
        planStore[safe: index]?.workState = workState
    }
}
