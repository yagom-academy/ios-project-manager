//
//  MemoRepository.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/11.
//

import Foundation

final class MemoRepository {
    private let memoStorage: MemoStorageable
    
    init(memoStorage: MemoStorageable = MemoStorage()) {
        self.memoStorage = memoStorage
    }
}

extension MemoRepository: Repositoryable {
    func add(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        memoStorage.create(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func delete(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        memoStorage.delete(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func update(memo: Memo, completion: @escaping (Result<Memo, Error>) -> Void) {
        memoStorage.update(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetch(completion: @escaping (Result<[Memo], Error>) -> Void) {
        memoStorage.fetch { result in
            switch result {
            case .success(let memos):
                completion(.success(memos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
