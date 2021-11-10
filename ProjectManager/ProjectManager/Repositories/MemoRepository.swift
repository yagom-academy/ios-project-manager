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
    func add() {
        
    }
    
    func delete() {
        
    }
    
    func update() {
        
    }
    
    func fetch() {
        
    }
}
