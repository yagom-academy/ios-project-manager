//
//  ProjectManagerCoordinator.swift
//  ProjectManager
//
//  Created by Erick on 2023/09/22.
//

import UIKit

final class ProjectManagerCoordinator {
    
    // MARK: - Private Property
    private var presenter: UINavigationController
    private let projectUseCase = DefaultProjectUseCase()
    
    // MARK: - Life Cycle
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        let mainViewModelActions = makeMainViewModelActions()
        
        let mainViewModel = DefaultMainViewModel(projectUseCase: projectUseCase, actions: mainViewModelActions)
        let todoProjectListViewModel = makeProjectListViewModel(projectUseCase: projectUseCase,
                                                                state: .toDo)
        let doingProjectListViewModel = makeProjectListViewModel(projectUseCase: projectUseCase,
                                                                 state: .doing)
        let doneProjectListViewModel = makeProjectListViewModel(projectUseCase: projectUseCase,
                                                                state: .done)
        
        let todoProjectListViewController = ProjectListViewController(viewModel: todoProjectListViewModel)
        let doingProjectListViewController = ProjectListViewController(viewModel: doingProjectListViewModel)
        let doneProjectListViewController = ProjectListViewController(viewModel: doneProjectListViewModel)
        
        let mainViewController = MainViewController(viewModel: mainViewModel,
                                                    toDoListViewController: todoProjectListViewController,
                                                    doingListViewController: doingProjectListViewController,
                                                    doneListViewController: doneProjectListViewController)
        
        presenter.setViewControllers([mainViewController], animated: true)
    }
    
    private func showProjectDetail(project: Project?) {
        let projectDetailViewModel = DefaultProjectDetailViewModel(projectUseCase: projectUseCase, project: project)
        let editProjectViewController = ProjectDetailViewController(viewModel: projectDetailViewModel)
        let detailViewController = UINavigationController(rootViewController: editProjectViewController)
        
        presenter.present(detailViewController, animated: true)
    }
    
    private func showAlert(alert: UIAlertController) {
        presenter.present(alert, animated: true)
    }
    
    private func makeMainViewModelActions() -> MainViewModelActions {
        return MainViewModelActions(showProjectDetail: showProjectDetail)
    }
    
    private func makeProjectListViewModelActions() -> ProjectListViewModelAction {
        return ProjectListViewModelAction(showProjectDetail: showProjectDetail,
                                          showPopAlert: showAlert)
    }
    
    private func makeProjectListViewModel(projectUseCase: ProjectUseCase, state: State) -> ProjectListViewModel {
        return DefaultProjectListViewModel(
            projectUseCase: projectUseCase,
            actions: makeProjectListViewModelActions(),
            state: state
        )
    }
}
