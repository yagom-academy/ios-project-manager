//
//  TodoListCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/14.
//

import UIKit

final class TodoListCoordinator: Coordinator, TodoListViewControllerDelegate {
    var rootViewController: UIViewController?
    
    func start() -> UIViewController {
        let todoListViewController = TodoListViewController()
        todoListViewController.delegate = self
        todoListViewController.todoListView.collectionView.transitionDelegate = self
        todoListViewController.doingListView.collectionView.transitionDelegate = self
        todoListViewController.doneListView.collectionView.transitionDelegate = self
        rootViewController = todoListViewController
        return rootViewController ?? UIViewController()
    }
    
    func addButtonDidTapped() {
        let formSheetViewCoordinator = FormSheetViewCoordinator(mode: .create)
        let creatVC = formSheetViewCoordinator.start()
        rootViewController?.present(creatVC, animated: true)
    }
    
    func cellDidTapped(at index: Int, in category: String) {
        let formSheetViewCoordinator = FormSheetViewCoordinator(mode: .edit,
                                                               category: category,
                                                               index: index)
        let editVC = formSheetViewCoordinator.start()
        rootViewController?.present(editVC, animated: true)
    }
    
    func cellDidLongPressed<T: ListCollectionView>(in view: T,
                                                   location: (x: Double, y: Double),
                                                   item: Todo?) {
        guard let item = item else { return }
        let popoverViewCoordinator = PopoverViewCoordinator(
            view: view,
            location: location,
            selectedTodo: item
        )
        let popoverVC = popoverViewCoordinator.start()
        rootViewController?.present(popoverVC, animated: true)
    }
    
    func historyButtonDidTapped(in viewController: TodoListViewController) {
        let historyViewCoordinator = HistoryViewCoordinator(viewController: viewController)
        let historyVC = historyViewCoordinator.start()
        rootViewController?.present(historyVC, animated: true)
    }
}
