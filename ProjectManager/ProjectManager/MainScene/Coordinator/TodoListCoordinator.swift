//
//  TodoListCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import UIKit

final class TodoListCoordinator: Coordinator, TodoListViewControllerDelegate {
    var rootViewController: UINavigationController?
    let viewModel = TodoListViewModel()
    
    func start() -> UIViewController {
        let todoListViewController = TodoListViewController(viewModel: viewModel)
        todoListViewController.delegate = self
        todoListViewController.todoListView.collectionView?.transitionDelegate = self
        todoListViewController.doingListView.collectionView?.transitionDelegate = self
        todoListViewController.doneListView.collectionView?.transitionDelegate = self
        rootViewController = UINavigationController(rootViewController: todoListViewController)
        return rootViewController ?? UIViewController()
    }
    
    func addButtonDidTapped() {
        let createTodoListCoordinator = CreateTodoListCoordinator(viewModel: viewModel)
        let creatVC = createTodoListCoordinator.start()
        rootViewController?.present(creatVC, animated: true)
    }
    
    func cellDidTapped(at index: Int, in category: String) {
        let editTodoListCoordinator = EditTodoListCoordinator(viewModel: viewModel,
                                                              category: category,
                                                              index: index)
        let editVC = editTodoListCoordinator.start()
        rootViewController?.present(editVC, animated: true)
    }

    func cellDidLongPressed<T: ListCollectionView>(in view: T,
                                                   location: (x: Double, y: Double),
                                                   item: Todo?) {
        guard let item = item else { return }
        let popoverViewCoordinator = PopoverViewCoordinator(
            viewModel: viewModel,
            view: view,
            location: location,
            selectedTodo: item
        )
        let popoverVC = popoverViewCoordinator.start()
        rootViewController?.present(popoverVC, animated: true)
    }
}
