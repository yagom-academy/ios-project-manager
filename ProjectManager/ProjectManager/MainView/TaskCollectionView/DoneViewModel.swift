//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine

final class DoneViewModel: PlanListViewModel {
    var planList: [Plan] = [] {
        didSet {
            currentplanSubject.send((planList, isUpdating))
        }
    }
    let currentplanSubject = PassthroughSubject<([Plan], Bool), Never>()
    var planWorkState: WorkState = .done
    var delegate: planListViewModelDelegate?
    
    private var isUpdating: Bool = false
    
    func setState(isUpdating: Bool) {
        self.isUpdating = isUpdating
    }
}

extension DoneViewModel: DetailViewModelDelegate { }
