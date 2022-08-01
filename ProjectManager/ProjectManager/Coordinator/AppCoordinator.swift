//
//  MainCoordinator.swift
//  ProjectManager
//
//  Created by Eddy on 2022/07/11.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }

    func start()
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    private let database = DatabaseManager()
    private let notificationManager = NotificationManager()
    private var detailViewController: DetailViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        self.notificationManager.requestAuthorization()
        self.showListView()
    }

    private func showListView() {
        let listViewModel = TodoListViewModel(dataBase: self.database, notificationManger: self.notificationManager)
        let todoListViewController = TodoListViewController(
            todoViewModel: listViewModel,
            coordinator: self
        )
        self.navigationController.pushViewController(todoListViewController, animated: false)
    }

    func showDetailView(todoListItemStatus: TodoListItemStatus? = .todo, selectedTodo: Todo? = nil) {
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }

        let detailViewModel = DetailViewModel(database: self.database, notificationManager: self.notificationManager)
        self.detailViewController = DetailViewController(
            selectedTodo: selectedTodo,
            todoListItemStatus: todoListItemStatus,
            detailViewModel: detailViewModel,
            coordinator: self
        )

        guard let detailViewController = detailViewController else {
            return
        }

        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.modalPresentationStyle = .formSheet
        self.navigationController.present(navigationController, animated: false)
    }

    func dismiss() {
        self.detailViewController?.dismiss(animated: true)
    }

    func showHistory(historyButton: UIBarButtonItem?) {
        guard let historyButton = historyButton else {
            return
        }

        let historyViewModel = HistoryViewModel(database: self.database)
        let historyView = HistoryViewController(viewModel: historyViewModel)
        historyView.modalPresentationStyle = .popover
        historyView.popoverPresentationController?.barButtonItem = historyButton

        self.navigationController.present(historyView, animated: true)
    }

    func showPopover(
        sourceView: UIView,
        firstTitle: String,
        secondTitle: String,
        firstAction: @escaping ()-> Void,
        secondAction: @escaping ()-> Void
    ) {
        let popover: UIAlertController = {
            let alertController = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet
            )
            alertController.modalPresentationStyle = .popover
            alertController.popoverPresentationController?.permittedArrowDirections = .up
            alertController.popoverPresentationController?.sourceView = sourceView.superview
            alertController.popoverPresentationController?.sourceRect = CGRect(origin: sourceView.center, size: .zero)

            return alertController
        }()

        let firstAction = UIAlertAction(title: firstTitle, style: .default) { action in
            firstAction()
        }
        let secondAction = UIAlertAction(title: secondTitle, style: .default) { action in
            secondAction()
        }
        popover.addAction(firstAction)
        popover.addAction(secondAction)
        self.navigationController.present(popover, animated: true)
    }
}
