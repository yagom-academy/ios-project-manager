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
        viewModelDictionary.forEach { workState, viewModel in
            let filteredPlanList = planList.filter { $0.workState == workState }
            viewModel.planList = filteredPlanList
        }
    }
    
    func todoViewModel() -> PlanListViewModel? {
        return viewModelDictionary[.todo]
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
    func changeWorkState(planID: UUID, with workState: WorkState) {
        service.changeWorkState(planID: planID, with: workState)
        fetchPlanList()
        distributePlan()
    }
}
