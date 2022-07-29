//
//  ProjectUseCase.swift
//  ProjectManager
//
//  Created by Tiana, mmim on 2022/07/12.
//

import RxSwift
import RxRelay

struct ProjectUseCase {
    private let projectRepository: ProjectRepositoryProtocol
    private let networkRepository: NetworkRepository
    private let historyRepository: HistoryRepository

    init(projectRepository: ProjectRepositoryProtocol,
         networkRepository: NetworkRepository,
         historyRepository: HistoryRepository
    ) {
        self.projectRepository = projectRepository
        self.networkRepository = networkRepository
        self.historyRepository = historyRepository
    }
    
    func create(projectContent: ProjectEntity) {
        projectRepository.create(projectContent: projectContent)
    }
    
    func read() -> BehaviorRelay<[ProjectEntity]> {
        return projectRepository.read()
    }
    
    func read(id: UUID?) -> ProjectEntity? {
        return projectRepository.read(id: id)
    }
    
    func update(projectContent: ProjectEntity) {
        projectRepository.update(projectContent: projectContent)
    }
    
    func delete(projectContentID: UUID?) {
        projectRepository.delete(projectContentID: projectContentID)
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
