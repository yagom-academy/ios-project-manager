//
//  MainViewCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

final class MainViewCoordinator {

    var navigationController: UINavigationController
    var mainViewController: MainViewController

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.mainViewController = MainViewController()
    }

    func start() {
        guard let dataSource = RealmService() else { return }
        self.mainViewController.viewModel = MainViewModel(
            coordinator: self,
            sceduleUseCase: ScheduleUseCase(
                scheduleRepository: DefaultScheduleRepository(
                    dataSource: dataSource,
                    remoteDataSource: FirestoreService()
                )
            ),
            scheduleHistoryUseCase: ScheduleHistoryUseCase(
                historyRepository: DefaultScheduleHistoryRepository()
            )
        )

        self.navigationController.viewControllers = [self.mainViewController]
    }

    func presentScheduleItemViewController(mode: ScheduleItemViewModel.Mode) {
        guard let useCase = self.mainViewController.viewModel?.scheduleUseCase as? ScheduleItemUseCase else {
            return
        }

        guard let historyUseCase = self.mainViewController.viewModel?.scheduleHistoryUseCase else {
            return
        }

        let scheduleDetailCoordinator = ScheduleItemCoordinator()
        scheduleDetailCoordinator.start(
            with: useCase,
            scheduleHistoryUseCase: historyUseCase,
            mode: mode
        )

        self.present(scheduleDetailCoordinator.navigationController)
    }

    private func present(_ viewController: UIViewController) {
        self.mainViewController.present(viewController, animated: true, completion: nil)
    }
}
