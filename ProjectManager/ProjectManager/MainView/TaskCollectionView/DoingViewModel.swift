//
//  DoingViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Combine
import Foundation

final class DoingViewModel: PlanListViewModel {
    var planList: [Plan] = []
    var planCreated = PassthroughSubject<Void, Never>()
    var planUpdated = PassthroughSubject<UUID, Never>()
    var planDeleted = PassthroughSubject<UUID, Never>()
    let planWorkState: WorkState = .doing

    weak var delegate: PlanListViewModelDelegate?
}

extension DoingViewModel: DetailViewModelDelegate { }
