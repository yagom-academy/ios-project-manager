//
//  DoneViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Foundation
import Combine

final class DoneViewModel: PlanListViewModel {
    var planList: [Plan] = []
    var planCountChanged = PassthroughSubject<Int, Never>()
    var planCreated = PassthroughSubject<Void, Never>()
    var planUpdated = PassthroughSubject<UUID, Never>()
    var planDeleted = PassthroughSubject<UUID, Never>()
    let planWorkState: WorkState = .done

    weak var delegate: PlanListViewModelDelegate?
}

extension DoneViewModel: DetailViewModelDelegate { }
