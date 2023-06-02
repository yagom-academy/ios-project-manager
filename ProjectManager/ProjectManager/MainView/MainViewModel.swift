//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/24.
//

import Foundation

final class MainViewModel {
    private var planListDictionary: [WorkState: [Plan]] = [:]
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
        let todoList = service.fetchPlanList().filter { $0.workState == .todo }
        let doingList = service.fetchPlanList().filter { $0.workState == .doing }
        let doneList = service.fetchPlanList().filter { $0.workState == .done }
        
        planListDictionary[.todo] = todoList
        planListDictionary[.doing] = doingList
        planListDictionary[.done] = doneList
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
        guard let planList = planListDictionary[workState] else {
            return
        }
        
        viewModelDictionary[workState]?.planList = planList
    }
}

extension MainViewModel: PlanListViewModelDelegate {
    func create(plan: Plan) {
        service.create(plan: plan)
    }
    
    func update(plan: Plan) {
        service.update(plan: plan)
    }
    
    func deletePlan(id: UUID) {
        service.deletePlan(id: id)
    }
}

extension MainViewModel: ChangeWorkStateViewModelDelegate {
    func changeWorkState(of plan: Plan, to workState: WorkState) {
        guard var planList = planListDictionary[plan.workState],
              var targetList = planListDictionary[workState],
              let targetIndex = planList.firstIndex(of: plan) else { return }
        
        let target = planList.remove(at: targetIndex)
        targetList.append(target)
        
        planListDictionary[plan.workState] = planList
        planListDictionary[workState] = targetList
        
        providePlanList(workState: plan.workState)
        providePlanList(workState: workState)
        
        viewModelDictionary[plan.workState]?.planDeleted.send((planList.count, plan.id))
        viewModelDictionary[workState]?.planCreated.send((targetList.count))
        service.changeWorkState(planID: plan.id, with: workState)
    }
}
