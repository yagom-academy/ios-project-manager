//
//  TodoHistoryDIContainer.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/26.
//

import UIKit

final class TodoHistoryFactory {
    struct Dependencies {
        let historyUseCase: TodoHistoryUseCaseable
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension TodoHistoryFactory {
    func makeTodoHistoryTableViewController() -> TodoHistoryTableViewController {
        return TodoHistoryTableViewController(makeTodoHistoryViewModel())
    }
    
    private func makeTodoHistoryViewModel() -> TodoHistoryTableViewModelable {
        return TodoHistoryTableViewModel(historyUseCase: dependencies.historyUseCase)
    }
    
    func makeHistoryViewCoordinator(navigationController: UINavigationController) -> TodoHistoryViewCoordinator {
        return TodoHistoryViewCoordinator(navigationController: navigationController, factory: self)
    }
}
