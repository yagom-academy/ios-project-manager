//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

protocol ProjectUseCase {
    func create(projectEntity: ProjectEntity)
    func read() -> BehaviorRelay<[ProjectEntity]>
    func read(projectEntityID: UUID?) -> ProjectEntity?
    func update(projectEntity: ProjectEntity)
    func delete(projectEntityID: UUID?)
    func load() -> Disposable
    func backUp()
    func createHistory(historyEntity: HistoryEntity)
    func readHistory() -> BehaviorRelay<[HistoryEntity]>
}

struct DefaultProjectUseCase: ProjectUseCase {
    private let projectRepository: PersistentRepositoryProtocol
    private let networkRepository: NetworkRepositoryProtocol
    private let historyRepository: HistoryRepositoryProtocol

    init(projectRepository: PersistentRepositoryProtocol,
         networkRepository: NetworkRepositoryProtocol,
         historyRepository: HistoryRepositoryProtocol
    ) {
        self.projectRepository = projectRepository
        self.networkRepository = networkRepository
        self.historyRepository = historyRepository
    }
    
    func create(projectEntity: ProjectEntity) {
        projectRepository.create(projectEntity: projectEntity)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return projectRepository.read()
    }
    
    func read(projectEntityID: UUID?) -> ProjectEntity? {
        return projectRepository.read(projectEntityID: projectEntityID)
    }
    
    func update(projectEntity: ProjectEntity) {
        projectRepository.update(projectEntity: projectEntity)
    }
    
    func delete(projectEntityID: UUID?) {
        projectRepository.delete(projectEntityID: projectEntityID)
    }
    
    func load() -> Disposable {
        return networkRepository.read(repository: projectRepository)
    }
    
    func backUp() {
        networkRepository.update(repository: projectRepository)
    }
    
    func createHistory(historyEntity: HistoryEntity) {
        historyRepository.create(historyEntity: historyEntity)
    }
    
    func readHistory() -> BehaviorRelay<[HistoryEntity]> {
        return historyRepository.read()
    }
}
