//
//  ProjectRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

protocol Storagable {
    func create(projectContent: ProjectContent)
    func create(projectContents: [ProjectContent])
    func read() -> BehaviorRelay<[ProjectContent]>
    func read(id: UUID?) -> ProjectContent?
    func update(projectContent: ProjectContent)
    func delete(projectContentID: UUID?)
    func deleteAll()
}

struct ProjectRepository {
    private let storageManager: Storagable

    init(storageManager: Storagable) {
        self.storageManager = storageManager
    }
}

extension ProjectRepository {
    func create(projectContent: ProjectContent) {
        storageManager.create(projectContent: projectContent)
    }
    
    func create(projectContents: [ProjectContent]) {
        storageManager.create(projectContents: projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectContent]> {
        return storageManager.read()
    }
    
    func read(id: UUID?) -> ProjectContent? {
        return storageManager.read(id: id)
    }
    
    func update(projectContent: ProjectContent) {
        storageManager.update(projectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        storageManager.delete(projectContentID: projectContentID)
    }
    
    func deleteAll() {
        storageManager.deleteAll()
    }
}
