//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Groot on 2022/09/08.
//

struct ProjectUseCase: ProjectUseCaseProtocol, ProjectTranslater {
    var repository: ProjectRepositoryProtocol
    
    init() {
        repository = TemporaryProjectRepository()
    }
    
    mutating func create(data: ProjectViewModel) {
        repository.create(data: translateToProjectModel(with: data))
    }
    
    func read() -> [ProjectViewModel] {
        let models = repository.read().map {
            translateToProjectViewModel(with: $0)
        }
        
        return models
    }
    
    mutating func update(id: String,
                         data: ProjectViewModel) {
        
        repository.update(id: id, data: translateToProjectModel(with: data))
    }
    
    mutating func delete(id: String) {
        repository.delete(id: id)
    }
}
