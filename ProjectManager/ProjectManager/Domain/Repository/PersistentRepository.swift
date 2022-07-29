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
    func create(projectContent: ProjectEntity)
    func create(projectContents: [ProjectEntity])
    func read() -> BehaviorRelay<[ProjectEntity]>
    func read(id: UUID?) -> ProjectEntity?
    func update(projectContent: ProjectEntity)
    func delete(projectContentID: UUID?)
    func deleteAll()
}

struct PersistentRepository: PersistentRepositoryProtocol {
    let persistentStorage: PersistentStorageProtocol
    
    init(persistentStorage: PersistentStorageProtocol) {
        self.persistentStorage = persistentStorage
    }
}

extension PersistentRepository {
    func create(projectContent: ProjectEntity) {
        persistentStorage.create(projectContent: projectContent)
    }
    
    func create(projectContents: [ProjectEntity]) {
        persistentStorage.create(projectContents: projectContents)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return persistentStorage.read()
    }
    
    func read(id: UUID?) -> ProjectEntity? {
        return persistentStorage.read(id: id)
    }
    
    func update(projectContent: ProjectEntity) {
        persistentStorage.update(projectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        persistentStorage.delete(projectContentID: projectContentID)
    }
    
    func deleteAll() {
        persistentStorage.deleteAll()
    }
}
