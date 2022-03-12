//
//  PopoverCoordinator.swift
//  ProjectManager
//
//  Created by Jae-hoon Sim on 2022/03/11.
//

import UIKit

private enum Design {
    static let viewControllerPrefferesContentSize = CGSize(width: 230, height: 100)
}

class PopoverCoordinator {

    let popoverViewController: PopoverViewController = {
        let viewController = PopoverViewController()
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = Design.viewControllerPrefferesContentSize
        viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        return viewController
    }()

    func start(with useCase: ScheduleUseCase, sourceView: UIView) {
        self.popoverViewController.viewModel = PopoverViewModel(
            useCase: useCase,
            coordinator: self
        )

        self.popoverViewController.popoverPresentationController?.sourceView = sourceView
    }

    func dismiss() {
        self.popoverViewController.dismiss(animated: true, completion: nil)
    }
}
