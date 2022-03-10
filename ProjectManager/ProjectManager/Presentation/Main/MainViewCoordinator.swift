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
        dataSource.storage = [
            Schedule(title: "1번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
            Schedule(title: "2번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .done),
            Schedule(title: "3번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing),
            Schedule(title: "4번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .todo),
            Schedule(title: "5번 스케줄", body: "ㅇㅇㅇ", dueDate: Date(), progress: .doing)
        ]
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
        guard let useCase = mainViewController.viewModel?.useCase else {
            return
        }

        let scheduleDetailCoordinator = ScheduleItemCoordinator()
        scheduleDetailCoordinator.start(with: useCase, mode: mode)

        self.mainViewController.present(scheduleDetailCoordinator.navigationController, animated: true, completion: nil)
    }
}
