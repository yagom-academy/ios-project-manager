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
    var planCountChanged = PassthroughSubject<Int, Never>()
    var planCreated = PassthroughSubject<Int, Never>()
    var planUpdated = PassthroughSubject<UUID, Never>()
    var planDeleted = PassthroughSubject<(Int, UUID), Never>()
    let planWorkState: WorkState = .doing

    weak var delegate: PlanListViewModelDelegate?
}

extension DoingViewModel: DetailViewModelDelegate { }
