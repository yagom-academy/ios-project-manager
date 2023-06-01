//
//  planCollectionViewModel.swift
//  ProjectManager
//
//  Created by Brody, Rowan on 2023/05/19.
//

import Foundation
import Combine

final class TodoViewModel: PlanListViewModel {
    var planList: [Plan] = []
    var planCreated = PassthroughSubject<Void, Never>()
    var planUpdated = PassthroughSubject<UUID, Never>()
    var planDeleted = PassthroughSubject<UUID, Never>()

    weak var delegate: PlanListViewModelDelegate?
}

extension TodoViewModel: DetailViewModelDelegate { }


// viewModel에서 deletePublisher를 들고있고
// view에서는 이 deletePublisher를 구독하면서 deleteSnapshot을 실행.(id를 넣어서)

// 만약 delete가 일어난다면 viewmodel.delete함수가 실행되고 그 함수내부에서 deletePublisher에 id를 전달.
// delete함수안에서 planList에서 remove, publisher에 id전달하는 거, service Delete.
// view에서는 이 deletePublisher가 변경될 때마다 deleteMethod를 실행.

// modify
