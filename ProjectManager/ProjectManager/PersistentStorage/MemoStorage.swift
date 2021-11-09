//
//  MemoStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation

enum MemoStorageError: Error, LocalizedError {
    case notFound
    case multipleDuplicateResultsFound
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "일치하는 메모가 없습니다."
        case .multipleDuplicateResultsFound:
            return "다수의 중복된 메모가 발견되었습니다."
        }
    }
}

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
    
    private func find(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let predicate = NSPredicate(format: "id == %@", memo.id as CVarArg)
            let fetchRequest = MemoEntity.fetchRequest()
            fetchRequest.predicate = predicate
            
            do {
                let fetchResult = try context.fetch(fetchRequest)
                guard fetchResult.count < 2 else {
                    throw MemoStorageError.multipleDuplicateResultsFound
                }
                guard let memoEntity = fetchResult.first else {
                    throw MemoStorageError.notFound
                }
                completion(.success(memoEntity.toDomain()))
            } catch  {
                completion(.failure(error))
            }
        }
        
    }
}
