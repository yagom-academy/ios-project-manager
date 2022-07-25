//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

struct ProjectUseCase {
    #if DEBUG
        private let repository = ProjectRepository(storageManager: MockRepository.shared)
    #else
        private let repository = ProjectRepository(storageManager: PersistentRepository.shared)
    #endif
    private let historyRepository = HistoryRepository(storageManager: MockHistoryRepository.shared)

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
    
    func load() -> Disposable {
        return NetworkRepository.shared.read(repository: repository)
    }
    
    func backUp() {
        NetworkRepository.shared.update(repository: repository)
    }
    
    func createHistory(historyEntity: HistoryEntity) {
        historyRepository.create(historyEntity: historyEntity)
    }
    
    func readHistory() -> [HistoryEntity] {
        return historyRepository.read()
    }
}
