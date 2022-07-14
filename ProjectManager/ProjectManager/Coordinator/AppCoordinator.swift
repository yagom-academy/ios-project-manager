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
    private let dataBase = TempDataBase()
    
    func start() {
        self.showListView()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func showListView() {
        let viewModel = TodoListViewModel(dataBase: self.dataBase)
        let viewController = TodoListViewController(
            todoViewModel: viewModel,
            coordinator: self
        )
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func showDetailView(todoListItemStatus: TodoListItemStatus? = .todo, selectedTodo: Todo? = nil) {
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }
        
        let detailViewModel = DetailViewModel(dataBase: self.dataBase)
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
    
    func showPopOver(
        sourceView: UIView,
        firstTitle: String,
        secondTitle: String,
        firstAction: @escaping ()-> Void,
        secondAction: @escaping ()-> Void
    ) {
        let alert: UIAlertController = {
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
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        self.navigationController.present(alert, animated: true)
    }
}
