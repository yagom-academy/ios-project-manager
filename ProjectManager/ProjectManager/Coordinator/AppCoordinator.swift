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
    private var detailViewController: DetailViewController?
    private let database = DatabaseManager()
    
    func start() {
        self.showListView()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func showListView() {
        let listViewModel = TodoListViewModel(dataBase: self.database)
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
        
        let detailViewModel = DetailViewModel(database: self.database)
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
        
        let popover: UIAlertController = {
            let alertController = UIAlertController(
                title: "nil",
                message: "nil2",
                preferredStyle: .actionSheet
            )
            alertController.modalPresentationStyle = .popover
            alertController.popoverPresentationController?.permittedArrowDirections = .up
            alertController.popoverPresentationController?.barButtonItem = historyButton
            alertController.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: historyButton.width / 2, y: 0), size: .zero)
            
            return alertController
        }()
        
        self.navigationController.present(popover, animated: true)
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
