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
        let historyVC = HistoryViewController(viewModel: historyVM)
        historyVC.modalPresentationStyle = .popover
        historyVC.popoverPresentationController?.permittedArrowDirections = .up
        historyVC.popoverPresentationController?.delegate = viewController
        historyVC.popoverPresentationController?.sourceView = viewController.view
        historyVC.popoverPresentationController?.sourceRect = CGRect(x: 60,
                                                                     y: 60,
                                                                     width: 1,
                                                                     height: 1)
        return historyVC
    }
}
