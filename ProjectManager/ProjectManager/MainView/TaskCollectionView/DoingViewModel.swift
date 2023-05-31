//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoingViewModel: PlanListViewModel {
    var planList: [Plan] = [] {
        didSet {
            currentPlanSubject.send((planList, isUpdating))
        }
    }
    let currentPlanSubject = PassthroughSubject<([Plan], Bool), Never>()
    var planWorkState: WorkState = .doing
    var delegate: PlanListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension DoingViewModel: DetailViewModelDelegate { }
