//
//  AppCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/09.
//

import UIKit

final class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let viewModel = TodoListViewModel(models: []) // mock
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMainViewController()
    }
    
    func goToMainViewController() {
        let todoListViewController = TodoListViewController.create(with: viewModel, coordinator: self)
        setupMainNavigationBar(in: todoListViewController)
        navigationController.pushViewController(
            todoListViewController,
            animated: true
        )
    }
    
    private func setupMainNavigationBar(in viewController: UIViewController) {
        viewController.navigationItem.title = "Project Manager"
        viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonDidTapped)
        )
    }
    
    @objc private func addButtonDidTapped() {
        goToCreate()
    }
    
    func goToEdit(_ model: TodoModel) {
        let editVC = EditTodoListViewController.create(
            with: viewModel,
            cellData: model
        )
        let navCon = UINavigationController(
            rootViewController: editVC
        )
        navCon.modalPresentationStyle = .formSheet
        navigationController.present(navCon, animated: true)
    }
    
    func goToCreate() {
        let createVC = CreateTodoListViewController.create(with: viewModel)
        let navCon = UINavigationController(
            rootViewController: createVC
        )
        navCon.modalPresentationStyle = .formSheet
        navigationController.present(navCon, animated: true)
    }
    
    func showPopover<T: ListCollectionView>(at cell: UICollectionViewCell,
                                            in view: T,
                                            location: CGPoint,
                                            item: TodoModel?) {
        guard let item = item else { return }

        let popoverVM = PopoverViewModel(viewModel: viewModel, category: view.category, item: item)
        let popoverVC = PopoverViewController.create(with: popoverVM)
        popoverVC.preferredContentSize = CGSize(
            width: 250,
            height: 120
        )
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.sourceView = cell
        popoverVC.popoverPresentationController?.sourceRect = CGRect(
            x: location.x,
            y: location.y - cell.frame.minY,
            width: 1,
            height: 1
        )
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.delegate = view
        navigationController.present(popoverVC, animated: true)
    }
}
