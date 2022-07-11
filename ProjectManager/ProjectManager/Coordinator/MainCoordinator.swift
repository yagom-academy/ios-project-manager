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
    
    func start() {
        self.showListView()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func showListView() {
        let viewModel = TodoListViewModel()
        let viewController = TodoListViewController(
            todoViewModel: viewModel,
            coordinator: self
        )
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func showDetailView(type: TodoListType, status: Status) {
        let viewModel = TodoListViewModel()
        self.detailViewController = DetailViewController(
            type: type,
            status: status,
            viewModel: viewModel,
            coordinator: self
        )
        let navigationController = UINavigationController(rootViewController: self.detailViewController!)
        navigationController.modalPresentationStyle = .formSheet
        self.navigationController.present(navigationController, animated: false)
    }
    
    func dismiss() {
        detailViewController?.dismiss(animated: true)
    }
}
