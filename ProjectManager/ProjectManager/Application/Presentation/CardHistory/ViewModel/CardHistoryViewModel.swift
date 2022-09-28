//
//  CardHistoryViewModel.swift
//  ProjectManager
//
//  Created by Derrick kim on 2022/09/25.
//

import Foundation

class CardHistoryViewModel {
    private let repositoryService = RepositoryService.shared

    var cardHistoryModelList: [CardHistoryModel] = [] {
        didSet {
            reloadHistoryTableViewClosure?(cardHistoryModelList)
        }
    }
    
    var reloadHistoryTableViewClosure: (([CardHistoryModel]) -> Void)?
    
    init() {
        fetchData()
    }

    func fetchData() {
        self.cardHistoryModelList = repositoryService.fetchCardHistoryModel().sorted {$0.date > $1.date}
    }
}
