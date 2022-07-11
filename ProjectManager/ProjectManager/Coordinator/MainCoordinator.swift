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
    
    func start() {
        self.showListView()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func showListView() {
        let viewModel = TodoListViewModel()
        let viewController = TodoListViewController(todoViewModel: viewModel, coordinator: self)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func showDetailView(type: TodoListType, status: Status) {
        let viewController = DetailViewController(type: type, status: status)
        viewController.coordinator = self
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .formSheet
        self.navigationController.present(navigationController, animated: false)
    }
}
