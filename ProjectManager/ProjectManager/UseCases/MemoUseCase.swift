//
//  MemoUseCase.swift
//  ProjectManager
//
//  Created by Kim Do hyung on 2021/11/09.
//

import Foundation

protocol UseCase {
    typealias Completion = (Result<Memo, Error>) -> Void
    func add(_ memo: Memo, completion: @escaping Completion)
    func modify(_ memo: Memo, completion: @escaping Completion)
    func delete(_ memo: Memo, completion: @escaping Completion)
    func move(_ memo: Memo, completion: @escaping Completion)
}

struct MemoUseCase: UseCase {
    private let repository: Repositoryable

    func add(_ memo: Memo, completion: @escaping Completion) {
    }
    
    func modify(_ memo: Memo, completion: @escaping Completion) {
    }
    
    func delete(_ memo: Memo, completion: @escaping Completion) {
    }
    
    func move(_ memo: Memo, completion: @escaping Completion) {
    }
}
