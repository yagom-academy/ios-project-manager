//
//  HistoryStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/14.
//

import Foundation

final class HistoryStorage: HistoryStorageable {
    private let coreDataStorage = CoreDataStorage.shared
    
    func fetch(completion: @escaping(Result<[History], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest = HistoryEntity.fetchRequest()
            
            do {
                let fetchResult = try context.fetch(fetchRequest)
                let historyList = fetchResult.map { $0.toDomain() }
                completion(.success(historyList))
            } catch  {
                completion(.failure(error))
            }
        }
    }
}
