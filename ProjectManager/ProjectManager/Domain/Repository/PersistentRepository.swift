//
//  PersistentRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

protocol PersistentRepositoryProtocol {
    var storageManager: PersistentStorageProtocol { get }
    func create(projectContent: ProjectEntity)
    func create(projectContents: [ProjectEntity])
    func read() -> BehaviorRelay<[ProjectEntity]>
    func read(id: UUID?) -> ProjectEntity?
    func update(projectContent: ProjectEntity)
    func delete(projectContentID: UUID?)
    func deleteAll()
}

struct PersistentRepository: PersistentRepositoryProtocol {
    let storageManager: PersistentStorageProtocol
    
    init(storageManager: PersistentStorageProtocol) {
        self.storageManager = storageManager
    }
}

extension PersistentRepository {
    func create(projectContent: ProjectEntity) {
        storageManager.create(projectContent: projectContent)
    }
    
    func create(projectContents: [ProjectEntity]) {
        storageManager.create(projectContents: projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return storageManager.read()
    }
    
    func read(id: UUID?) -> ProjectEntity? {
        return storageManager.read(id: id)
    }
    
    func update(projectContent: ProjectEntity) {
        storageManager.update(projectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        storageManager.delete(projectContentID: projectContentID)
    }
    
    func deleteAll() {
        storageManager.deleteAll()
    }
}
