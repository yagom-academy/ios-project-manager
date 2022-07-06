//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import Foundation

protocol UseCase {}

final class TodoListUseCase: UseCase {
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
}
