//
//  TodoHistorySceneFactory.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import Foundation

final class TodoHistorySceneFactory {
    private unowned let storage: HistoryStorageable
    
    init(dependency: TodoHistorySceneDIContainer.Dependencies) {
        self.storage = dependency.storage
    }
    
    // MARK: - ViewControllers
    
    func makeViewController() -> TodoHistoryTableViewController {
        return TodoHistoryTableViewController(makeViewModel())
    }
    
    // MARK: - ViewModels
    
    private func makeViewModel() -> TodoHistoryTableViewModelable {
        return TodoHistoryTableViewModel(useCase: makeUseCase())
    }
    
    // MARK: - UseCase
    
    private func makeUseCase() -> TodoHistoryUseCaseable {
        return TodoHistoryUseCase(repository: makeRepository())
    }
    
    // MARK: - Repository
    
    private func makeRepository() -> TodoHistoryRepositorible {
        return TodoHistoryRepository(storage: storage)
    }
}
