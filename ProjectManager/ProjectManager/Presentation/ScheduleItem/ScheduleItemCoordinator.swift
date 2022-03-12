//
//  ScheduleDetailCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

class ScheduleItemCoordinator {

    let navigationController = UINavigationController()
    private let scheduleDetailViewController = ScheduleItemViewController()

    func start(with useCase: ScheduleUseCase, mode: ScheduleItemViewModel.Mode) {
        self.scheduleDetailViewController.viewModel = ScheduleItemViewModel(
            useCase: useCase,
            coordinator: self,
            mode: mode
        )

        self.navigationController.viewControllers = [self.scheduleDetailViewController]
    }

    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
