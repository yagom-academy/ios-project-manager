//
//  ScheduleDetailCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

class ScheduleDetailCoordinator {

    let navigationController = UINavigationController()
    private let scheduleDetailViewController = ScheduleDetailViewController()

    func start(with useCase: ScheduleUseCase) {
        self.scheduleDetailViewController.viewModel = ScheduleDetailViewModel(
            useCase: useCase,
            coordinator: self
        )

        self.navigationController.viewControllers = [self.scheduleDetailViewController]
    }

    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
