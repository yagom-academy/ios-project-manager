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

final class MainCoordinator: Coordinator {
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
    
    func showDetailView(type: DetailViewType, todoListItemStatus: TodoListItemStatus?) {
        let viewModel = DetailViewModel(dataBase: self.dataBase)
        guard let todoListItemStatus = todoListItemStatus else {
            return
        }
        self.detailViewController = DetailViewController(
            detailViewType: type,
            todoListItemStatus: todoListItemStatus,
            detailViewModel: viewModel,
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
}
