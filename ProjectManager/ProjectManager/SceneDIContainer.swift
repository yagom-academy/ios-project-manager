//
//  SceneDIContainer.swift
//  ProjectManager
//
//  Created by 조성훈 on 2022/07/27.
//

import UIKit

final class SceneDIContainer {
    lazy var projectUseCase = makeProjectUseCase()
    
    // MARK: - Manager
    
    private func makePersistentManager() -> PersistentManager {
        return PersistentManager()
    }
    
    private func makeNetworkManager() -> NetworkManager {
        return NetworkManager()
    }
    
    // MARK: - Storage
    
    private func makePersistentRepository() -> PersistentStorage {
        return PersistentStorage(persistentManager: makePersistentManager())
    }
    
    private func makeNetworkRepository() -> NetworkRepository {
        return NetworkRepository(networkManager: makeNetworkManager())
    }
    
    private func makeHistoryManager() -> HistoryManager {
        return HistoryManager()
    }
    
    // MARK: - Repository
    
    private func makeProjectRepository() -> ProjectRepository {
        return ProjectRepository(storageManager: makePersistentRepository())
    }
    
    private func makeHistoryRepository() -> HistoryRepository {
        return HistoryRepository(storageManager: makeHistoryManager())
    }
    
    // MARK: - Use Cases
    
    private func makeProjectUseCase() -> ProjectUseCase {
        return ProjectUseCase(
            projectRepository: makeProjectRepository(),
            networkRepository: makeNetworkRepository(),
            historyRepository: makeHistoryRepository()
        )
    }
    
    // MARK: - Main
    
    private func makeMainViewModel() -> MainViewModel {
        return MainViewModel(projectUseCase: projectUseCase)
    }
    
    func makeMainViewController(with sceneDIContainer: SceneDIContainer) -> MainViewController {
        return MainViewController(with: makeMainViewModel(), sceneDIContainer)
    }
    
    // MARK: - PopOver
    
    private func makePopOverViewModel(with cell: ProjectCell) -> PopOverViewModel {
        return PopOverViewModel(projectUseCase: projectUseCase, cell: cell)
    }
    
    func makePopOverViewController(with cell: ProjectCell) -> PopOverViewController {
        return PopOverViewController(with: makePopOverViewModel(with: cell))
    }
    
    // MARK: - History
    
    private func makeHistoryViewModel() -> HistoryViewModel {
        return HistoryViewModel(projectUseCase: projectUseCase)
    }
    
    func makeHistoryViewController(with source: UIBarButtonItem) -> HistoryViewController {
        return HistoryViewController(with: makeHistoryViewModel(), source: source)
    }
    
    // MARK: - Detail
    
    private func makeDetailViewModel(with projectEntity: ProjectEntity) -> DetailViewModel {
        return DetailViewModel(projectUseCase: projectUseCase, content: projectEntity)
    }
    
    func makeDetailViewController(with projectEntity: ProjectEntity) -> DetailViewController {
        return DetailViewController(with: makeDetailViewModel(with: projectEntity))
    }
    
    // MARK: - Registration
    
    private func makeRegistrationViewModel() -> RegistrationViewModel {
        return RegistrationViewModel(projectUseCase: projectUseCase)
    }
    
    func makeRegistrationViewController() -> RegistrationViewController {
        return RegistrationViewController(with: makeRegistrationViewModel())
    }
    
    // MARK: - Alert
    
    func makeAlertController(over: UIViewController, title: String, confirmButton: UIAlertAction?) -> AlertController {
        return AlertController(over: over, title: title, confirmButton: confirmButton)
    }
    
}
