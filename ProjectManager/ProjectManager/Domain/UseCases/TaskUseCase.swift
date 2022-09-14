//
//  TaskUseCase.swift
//  ProjectManager
//
//  Created by 이예은 on 2022/09/15.
//

import Foundation

class TaskUseCase: TaskUseCaseProtocol {
    private var repository = TaskRepository()

    func insertContents(data: TaskModelDTO) {
        repository.insertContent(model: data)
    }
    
    func fetch() -> [TaskModelDTO] {
        return repository.fetch()
    }
    
    func update(data: TaskModelDTO) {
        repository.update(model: data)
    }
    
    func delete(data: TaskModelDTO) {
        repository.delete(model: data)
    }
}
