//
//  MainViewCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

class MainViewCoordinator {

    var navigationController: UINavigationController
    var mainViewController: MainViewController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mainViewController = MainViewController()
    }

    func start() {
        let dataSource = MemoryDataSource()
        self.mainViewController.viewModel = MainViewModel(
            coordinator: self,
            useCase: ScheduleUseCase(
                repository: DataRepository(
                    dataSource: dataSource
                )
            )
        )

        self.navigationController.viewControllers = [self.mainViewController]
    }

    func presentScheduleItemViewController(mode: ScheduleItemViewModel.Mode) {
        guard let useCase = self.mainViewController.viewModel?.useCase else {
            return
        }

        let scheduleDetailCoordinator = ScheduleItemCoordinator()
        scheduleDetailCoordinator.start(with: useCase, mode: mode)

        self.present(scheduleDetailCoordinator.navigationController)
    }

    func presentPopoverViewController(at sourceView: UIView) {
        guard let useCase = self.mainViewController.viewModel?.useCase else {
            return
        }

        let popoverCoordinator = PopoverCoordinator()
        popoverCoordinator.start(with: useCase, sourceView: sourceView)

        self.present(popoverCoordinator.popoverViewController)
    }

    private func present(_ viewController: UIViewController) {
        self.mainViewController.present(viewController, animated: true, completion: nil)
    }
}
