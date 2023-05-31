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
    
    func createplan(_ plan: Plan)
    func updateplan(_ plan: Plan)
    func deleteplan(at index: Int)
    func plan(at index: Int) -> Plan?
    func setState(isUpdating: Bool)
}

extension PlanListViewModel {
    func createplan(_ plan: Plan) {
        planList.append(plan)
        delegate?.createplan(plan)
    }
    
    func updateplan(_ plan: Plan) {
        guard let targetIndex = planList.firstIndex(where: { $0.id == plan.id }) else {
            return
        }
        
        planList[targetIndex] = plan
        delegate?.updateplan(plan)
    }
    
    func deleteplan(at index: Int) {
        let plan = planList.remove(at: index)
        delegate?.deleteplan(id: plan.id)
    }
    
    func plan(at index: Int) -> Plan? {
        return planList[safe: index]
    }
}
