//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation

final class MainViewModel {
    private var planList: [Plan] = []
    private var viewModelDictionary: [WorkState: PlanListViewModel] = [:]
    private let service: PlanStorageService
    
    init(service: PlanStorageService) {
        self.service = service
    }
    
    func assignChildViewModel(of children: [PlanListViewModel]) {
        children
            .forEach {
                $0.delegate = self
                viewModelDictionary[$0.planWorkState] = $0
            }
    }
    
    func fetchPlanList() {
        planList = service.fetchPlanList()
    }
    
    func distributePlan() {
        providePlanList(workState: .todo)
        providePlanList(workState: .doing)
        providePlanList(workState: .done)
    }
    
    func todoViewModel() -> PlanListViewModel? {
        return viewModelDictionary[.todo]
    }
    
    private func providePlanList(workState: WorkState) {
        viewModelDictionary[workState]?.planList = planList.filter { $0.workState == workState }
    }
}

extension MainViewModel: PlanListViewModelDelegate {
    func create(plan: Plan) {
        planList.append(plan)
        service.create(plan: plan)
    }
    
    func update(plan: Plan) {
        guard let targetIndex = planList.firstIndex(of: plan) else { return }
        
        planList[targetIndex] = plan
        service.update(plan: plan)
    }
    
    func deletePlan(id: UUID) {
        guard let targetIndex = planList.firstIndex(where: { $0.id == id }) else { return }
        
        planList.remove(at: targetIndex)
        service.deletePlan(id: id)
    }
}

extension MainViewModel: ChangeWorkStateViewModelDelegate {
    func changeWorkState(of plan: Plan, to workState: WorkState) {
        guard let targetIndex = planList.firstIndex(of: plan) else { return }
        planList[targetIndex].workState = workState
        providePlanList(workState: plan.workState)
        providePlanList(workState: workState)
        
        let deletedPlanListCount = planList.filter { $0.workState == plan.workState }.count
        let targetPlanListCount = planList.filter { $0.workState == workState }.count
        
        viewModelDictionary[plan.workState]?.planDeleted.send((deletedPlanListCount, plan.id))
        viewModelDictionary[workState]?.planCreated.send((targetPlanListCount))
        service.changeWorkState(planID: plan.id, with: workState)
    }
}
