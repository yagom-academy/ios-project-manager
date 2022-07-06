//
//  TodoListRepository.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

final class TodoListRepository: Repository {
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
}
