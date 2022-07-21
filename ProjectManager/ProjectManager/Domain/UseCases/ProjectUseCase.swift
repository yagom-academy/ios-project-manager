//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxRelay

struct ProjectUseCase {
    private let repository = ProjectRepository(storageManager: MockStorageManager.shared)
    
    func create(projectContents: [ProjectContent]) {
        repository.create(projectContents: projectContents)
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
}
