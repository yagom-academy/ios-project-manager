//
//  planCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class TodoViewModel: PlanListViewModel {
    var planList: [Plan] = [] {
        didSet {
            currentplanSubject.send((planList, isUpdating))
        }
    }
    let currentplanSubject = PassthroughSubject<([Plan], Bool), Never>()
    let planWorkState: WorkState = .todo
    var delegate: planListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension TodoViewModel: DetailViewModelDelegate { }
