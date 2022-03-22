//
//  ScheduleDetailCoordinator.swift
//  ProjectManager
//
//  Created by Lee Seung-Jae on 2022/03/09.
//

import UIKit

final class ScheduleItemCoordinator {

    let navigationController = UINavigationController()
    private let scheduleItemViewController = ScheduleItemViewController()

    func start(
        with scheduleUseCase: ScheduleItemUseCase,
        scheduleHistoryUseCase: ScheduleActionRecodeUseCase,
        mode: ScheduleItemViewModel.Mode
    ) {
        self.scheduleItemViewController.viewModel = ScheduleItemViewModel(
            scheduleUseCase: scheduleUseCase,
            scheduleHistoryUseCase: scheduleHistoryUseCase,
            coordinator: self,
            mode: mode
        )

        self.navigationController.viewControllers = [self.scheduleItemViewController]
    }

    func dismiss() {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
