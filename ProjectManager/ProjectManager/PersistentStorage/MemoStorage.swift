//
//  MemoStorage.swift
//  ProjectManager
//
//  Created by JINHONG AN on 2021/11/09.
//

import Foundation
import CoreData

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
    
    private func find(memo: Memo, in context: NSManagedObjectContext) -> Result<MemoEntity, Error> {
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
            return .success(memoEntity)
        } catch  {
            return .failure(error)
        }
    }
    
    private func createHistory(of memo: Memo, updateType: UpdateType, in context: NSManagedObjectContext) {
        let history = History(title: memo.title, updateType: updateType)
        _ = HistoryEntity(history: history, insertInto: context)
    }
}

extension MemoStorage: MemoStorageable {
    func create(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self = self else {
                return
            }
            let memoEntity = MemoEntity(memo: memo, insertInto: context)
            self.createHistory(of: memo, updateType: .create, in: context)
            
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
    
    func delete(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self = self else {
                return
            }
            let result = self.find(memo: memo, in: context)
            switch result {
            case .success(let memoEntity):
                context.delete(memoEntity)
                do {
                    try context.save()
                    completion(.success(memo))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { [weak self] context in
            guard let self = self else {
                return
            }
            let result = self.find(memo: memo, in: context)
            switch result {
            case .success(let memoEntity):
                memoEntity.change(to: memo)
                do {
                    try context.save()
                    completion(.success(memoEntity.toDomain()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
