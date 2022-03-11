//
//  PopoverCoordinator.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import UIKit

class PopoverCoordinator {

    let popoverViewController: PopoverViewController = {
        let viewController = PopoverViewController()
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: 230, height: 100)
        viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        return viewController
    }()

    func start(with useCase: ScheduleUseCase, sourceView: UIBarButtonItem) {
        self.popoverViewController.viewModel = PopoverViewModel(
            useCase: useCase,
            coordinator: self
        )
        self.popoverViewController.popoverPresentationController?.barButtonItem = sourceView
    }

    func dismiss() {
        self.popoverViewController.dismiss(animated: true, completion: nil)
    }
}
