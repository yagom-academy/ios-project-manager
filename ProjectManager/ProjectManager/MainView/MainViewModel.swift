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
    private let service: planStorageService
    
    init(service: planStorageService) {
        self.service = service
    }
    
    func assignChildViewModel(of children: [PlanListViewModel]) {
        children
            .forEach {
                $0.delegate = self
                viewModelDictionary[$0.planWorkState] = $0
            }
    }
    
    func fetchplanList() {
        planList = service.fetchplanList()
    }
    
    func distributeplan() {
        viewModelDictionary.forEach { workState, viewModel in
            let filteredplanList = planList.filter { $0.workState == workState }
            viewModel.planList = filteredplanList
        }
    }
    
    func todoViewModel() -> PlanListViewModel? {
        return viewModelDictionary[.todo]
    }
}

extension MainViewModel: planListViewModelDelegate {
    func createplan(_ plan: Plan) {
        service.createplan(plan)
    }
    
    func updateplan(_ plan: Plan) {
        service.updateplan(plan)
    }
    
    func deleteplan(id: UUID) {
        service.deleteplan(id: id)
    }
}

extension MainViewModel: ChangeWorkStateViewModelDelegate {
    func changeWorkState(planID: UUID, with workState: WorkState) {
        service.changeWorkState(planID: planID, with: workState)
        fetchplanList()
        distributeplan()
    }
}
