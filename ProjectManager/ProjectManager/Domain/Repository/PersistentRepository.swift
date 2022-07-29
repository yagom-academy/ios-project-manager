//
//  PersistentRepository.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

protocol PersistentRepositoryProtocol {
    var persistentStorage: PersistentStorageProtocol { get }
    func create(projectEntity: ProjectEntity)
    func create(projectEntities: [ProjectEntity])
    func read() -> BehaviorRelay<[ProjectEntity]>
    func read(projectEntityID: UUID?) -> ProjectEntity?
    func update(projectEntity: ProjectEntity)
    func delete(projectEntityID: UUID?)
    func deleteAll()
}

struct PersistentRepository: PersistentRepositoryProtocol {
    let persistentStorage: PersistentStorageProtocol
    
    init(persistentStorage: PersistentStorageProtocol) {
        self.persistentStorage = persistentStorage
    }
}

extension PersistentRepository {
    func create(projectEntity: ProjectEntity) {
        persistentStorage.create(projectEntity: projectEntity)
    }
    
    func create(projectEntities: [ProjectEntity]) {
        persistentStorage.create(projectEntities: projectEntities)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return persistentStorage.read()
    }
    
    func read(projectEntityID: UUID?) -> ProjectEntity? {
        return persistentStorage.read(id: projectEntityID)
    }
    
    func update(projectEntity: ProjectEntity) {
        persistentStorage.update(projectEntity: projectEntity)
    }
    
    func delete(projectEntityID: UUID?) {
        persistentStorage.delete(projectEntityID: projectEntityID)
    }
    
    func deleteAll() {
        persistentStorage.deleteAll()
    }
}
