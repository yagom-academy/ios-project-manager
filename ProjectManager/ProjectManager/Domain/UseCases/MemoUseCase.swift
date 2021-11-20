//
//  MemoUseCase.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/09.
//

import Foundation

protocol UseCase {
    typealias Completion = (Result<Memo, Error>) -> Void
    func createNewMemo(_ memo: Memo, completion: @escaping Completion)
    func reviseMemo(_ memo: Memo, completion: @escaping Completion)
    func deleteMemo(_ memo: Memo, completion: @escaping Completion)
    func bringMemos(completion: @escaping (Result<[Memo], Error>) -> Void)
}

struct MemoUseCase: UseCase {
    private let repository: Repositoryable
    
    init(repository: Repositoryable = MemoRepository()) {
        self.repository = repository
    }

    func createNewMemo(_ memo: Memo, completion: @escaping Completion) {
        repository.add(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func reviseMemo(_ memo: Memo, completion: @escaping Completion) {
        repository.update(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func deleteMemo(_ memo: Memo, completion: @escaping Completion) {
        repository.delete(memo: memo) { result in
            switch result {
            case .success(let memo):
                completion(.success(memo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func bringMemos(completion: @escaping (Result<[Memo], Error>) -> Void) {
        repository.fetch { result in
            switch result {
            case .success(let memos):
                completion(.success(memos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
