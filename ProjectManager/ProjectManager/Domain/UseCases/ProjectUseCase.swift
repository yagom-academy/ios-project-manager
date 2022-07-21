//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxRelay

struct ProjectUseCase {
    private let networkRepository = NetworkRepository()
    
    #if DEBUG
        private let repository = ProjectRepository(storageManager: MockRepository.shared)
    #else
        private let repository = ProjectRepository(storageManager: PersistentRepository.shared)
    #endif
    
    func create(projectContent: ProjectContent) {
        repository.create(projectContent: projectContent)
    }
    
    func read() -> BehaviorRelay<[ProjectContent]> {
        return repository.read()
    }
    
    func read(id: UUID?) -> ProjectContent? {
        return repository.read(id: id)
    }
    
    func update(projectContent: ProjectContent) {
        repository.update(projectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        repository.delete(projectContentID: projectContentID)
    }
    
    func load() {
        networkRepository.read(repository: repository)
    }
    
    func backUp() {
        networkRepository.update(repository: repository)
    }
}
