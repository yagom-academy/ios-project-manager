//
//  ScheduleDetailCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

class ScheduleItemCoordinator {

    let navigationController = UINavigationController()
    private let scheduleItemViewController = ScheduleItemViewController()

    func start(with useCase: ScheduleItemUseCase, mode: ScheduleItemViewModel.Mode) {
        self.scheduleItemViewController.viewModel = ScheduleItemViewModel(
            useCase: useCase,
            coordinator: self,
            mode: mode
        )

        self.navigationController.viewControllers = [self.scheduleItemViewController]
    }

    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
