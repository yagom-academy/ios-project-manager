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

    func start(with useCase: ScheduleUseCase, sourceView: UIView) {
        self.popoverViewController.viewModel = PopoverViewModel(
            useCase: useCase,
            coordinator: self
        )
        let sourceRect = CGRect(
            origin: sourceView.center,
            size: CGSize(
                width: sourceView.bounds.size.width,
                height: sourceView.bounds.size.height * 1/2
            )
        )
        self.popoverViewController.popoverPresentationController?.sourceView = sourceView
        self.popoverViewController.popoverPresentationController?.sourceRect = sourceRect
    }

    func dismiss() {
        self.popoverViewController.dismiss(animated: true, completion: nil)
    }
}
