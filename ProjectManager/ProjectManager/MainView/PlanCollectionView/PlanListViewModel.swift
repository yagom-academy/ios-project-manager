//
//  CollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation
import Combine

enum PlanCollectionViewError: Error {
    case deleteError
}

protocol PlanListViewModelDelegate: PlanManagable {
    func deletePlan(id: UUID)
}

protocol PlanListViewModel: AnyObject {
    var planList: [Plan] { get set }
    var planCountChanged: PassthroughSubject<Int, Never> { get }
    var planCreated: PassthroughSubject<Int, Never> { get }
    var planUpdated: PassthroughSubject<UUID, Never> { get }
    var planDeleted: PassthroughSubject<(Int, UUID), Never> { get }
    var planWorkState: WorkState { get }
    var delegate: PlanListViewModelDelegate? { get set }
    
    func create(plan: Plan)
    func update(plan: Plan)
    func delete(planID: UUID) throws
    func plan(at index: Int) -> Plan?
}

extension PlanListViewModel {
    func create(plan: Plan) {
        planList.append(plan)
        planCreated.send(planList.count)
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
    
    func delete(planID: UUID) throws {
        guard let index = planList.firstIndex(where: { $0.id == planID }) else {
            throw PlanCollectionViewError.deleteError
        }
        
        let plan = planList.remove(at: index)
        planDeleted.send((planList.count, planID))
        delegate?.deletePlan(id: plan.id)
    }
    
    func plan(at index: Int) -> Plan? {
        return planList[safe: index]
    }
}
