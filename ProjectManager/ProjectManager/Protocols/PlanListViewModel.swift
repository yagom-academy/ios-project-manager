//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Combine

protocol PlanListViewModel: AnyObject {
    var planList: [Plan] { get set }
    var currentPlanSubject: PassthroughSubject<([Plan], Bool), Never> { get }
    var planWorkState: WorkState { get }
    var delegate: PlanListViewModelDelegate? { get set }
    
    func create(plan: Plan)
    func update(plan: Plan)
    func deletePlan(at index: Int)
    func plan(at index: Int) -> Plan?
    func setState(isUpdating: Bool)
}

extension PlanListViewModel {
    func create(plan: Plan) {
        planList.append(plan)
        delegate?.create(plan: plan)
    }
    
    func update(plan: Plan) {
        guard let targetIndex = planList.firstIndex(where: { $0.id == plan.id }) else {
            return
        }
        
        planList[targetIndex] = plan
        delegate?.update(plan: plan)
    }
    
    func deletePlan(at index: Int) {
        let plan = planList.remove(at: index)
        delegate?.deletePlan(id: plan.id)
    }
    
    func plan(at index: Int) -> Plan? {
        return planList[safe: index]
    }
}
