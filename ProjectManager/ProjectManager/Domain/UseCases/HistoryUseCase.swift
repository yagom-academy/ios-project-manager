//
//  HistoryUseCase.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/14.
//

import Foundation

protocol HistoryUseCaseable {
    func bringChangeHistory(completion: @escaping (Result<[History], Error>) -> Void)
}

struct HistoryUseCase: HistoryUseCaseable {
    private let repository: HistoryRepositoryable
    
    init(repository: HistoryRepositoryable = HistoryRepository()) {
        self.repository = repository
    }
    
    func bringChangeHistory(completion: @escaping (Result<[History], Error>) -> Void) {
        repository.fetch { result in
            switch result {
            case .success(let histories):
                completion(.success(histories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
