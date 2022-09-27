//
//  HistoryViewCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/19.
//

import UIKit

final class HistoryViewCoordinator: Coordinator {
    let viewController: TodoListViewController
    
    init(viewController: TodoListViewController) {
        self.viewController = viewController
    }

    func start() -> UIViewController {
        let historyVM = HistoryViewModel(histories: TodoDataManager.shared.fetchHistory())
        let historyVC = HistoryTableViewController(viewModel: historyVM)
        historyVC.modalPresentationStyle = .popover
        historyVC.popoverPresentationController?.permittedArrowDirections = .up
        historyVC.popoverPresentationController?.delegate = viewController
        historyVC.popoverPresentationController?.barButtonItem = viewController.navigationItem.leftBarButtonItem
        return historyVC
    }
}
