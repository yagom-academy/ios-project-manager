//
//  MemoStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation

final class MemoStorage {
    private let coreDataStorage = CoreDataStorage.shared
    
    func create(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let memoEntity = MemoEntity(memo: memo, insertInto: context)
            
            do {
                try context.save()
                completion(.success(memoEntity.toDomain()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func fetch(completion: @escaping (Result<[Memo], Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest = MemoEntity.fetchRequest()
            
            do {
                let fetchResult = try context.fetch(fetchRequest)
                let memoList = fetchResult.map { $0.toDomain() }
                completion(.success(memoList))
            } catch  {
                completion(.failure(error))
            }
        }
    }
}
