//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation
import Combine

protocol PlanListViewModelDelegate: PlanManagable {
    func deletePlan(id: UUID)
}

protocol PlanListViewModel: AnyObject {
    var planList: [Plan] { get set }
    var planCreated: PassthroughSubject<Void, Never> { get }
    var planUpdated: PassthroughSubject<UUID, Never> { get }
    var planDeleted: PassthroughSubject<UUID, Never> { get }
    var planWorkState: WorkState { get }
    var delegate: PlanListViewModelDelegate? { get set }
    
    func create(plan: Plan)
    func update(plan: Plan)
    func delete(planID: UUID)
    func plan(at index: Int) -> Plan?
}

extension PlanListViewModel {
    func create(plan: Plan) {
        planList.append(plan)
        planCreated.send(())
        delegate?.create(plan: plan)
    }
    
    func update(plan: Plan) {
        guard let targetIndex = planList.firstIndex(where: { $0.id == plan.id }) else {
            return
        }
        
        planList[targetIndex] = plan
        planUpdated.send(plan.id)
        delegate?.update(plan: plan)
    }
    
    func delete(planID: UUID) {
        guard let index = planList.firstIndex(where: { $0.id == planID }) else {
            return
        }
        
        let plan = planList.remove(at: index)
        planDeleted.send(planID)
        delegate?.deletePlan(id: plan.id)
    }
    
    func plan(at index: Int) -> Plan? {
        return planList[safe: index]
    }
}
