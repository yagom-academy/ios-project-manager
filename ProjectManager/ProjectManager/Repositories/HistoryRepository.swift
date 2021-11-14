//
//  HistoryRepository.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/14.
//

import Foundation

final class HistoryRepository: HistoryRepositoryable {
    private let historyStorage: HistoryStorageable
    
    init(historyStorage: HistoryStorageable = HistoryStorage()) {
        self.historyStorage = historyStorage
    }
    
    func fetch(completion: @escaping (Result<[History], Error>) -> Void) {
        historyStorage.fetch { result in
            switch result {
            case .success(let histories):
                completion(.success(histories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
