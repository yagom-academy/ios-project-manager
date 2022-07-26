//
//  TodoHistoryDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoHistoryDIContainer {
    struct Dependencies {
        unowned let historyStorage: HistoryStorageable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoHistoryDIContainer {
    
    func makeHistoryViewCoordinator(navigationController: UINavigationController) -> TodoHistoryViewCoordinator {
        return TodoHistoryViewCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeTodoHistoryTableViewController() -> TodoHistoryTableViewController {
        return TodoHistoryTableViewController(makeTodoHistoryViewModel())
    }
    
    private func makeTodoHistoryViewModel() -> TodoHistoryTableViewModelable {
        return TodoHistoryTableViewModel(historyUseCase: makeTodoHistoryUseCase())
    }
    
    private func makeTodoHistoryUseCase() -> TodoHistoryUseCaseable {
        return TodoHistoryUseCase(repository: makeTodoHistoryRepository())
    }
    
    private func makeTodoHistoryRepository() -> TodoHistoryRepositorible {
        return TodoHistoryRepository(storage: dependencies.historyStorage)
    }
}
