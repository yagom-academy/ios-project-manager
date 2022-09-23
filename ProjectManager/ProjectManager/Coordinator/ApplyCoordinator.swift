//
//  ApplyCoordinator.swift
//  ProjectManager
//
//  Created by Baek on 2022/09/21.
//

import Foundation
import UIKit

class ApplyCoordinator: Coordinator {
    var coordinatorController: UINavigationController
    private var todoDetailViewController: TodoDetailViewController?
    private let database = DatabaseManager()
    
    init(navigationController: UINavigationController) {
        self.coordinatorController = navigationController
    }
    
    func moveStart() {
        self.passAwayTodoListView()
    }
    
    private func passAwayTodoListView() {
        let todoListViewModel = TodoListViewModel(database: self.database)
        let todoViewController = TodoListViewController(todoListModelView: todoListViewModel, coordinator: self)
        self.coordinatorController.pushViewController(todoViewController, animated: true)
    }
    
    func passAwayTodoDetailView(pickTodo: TodoModel? = nil, detailType: TodoDetailType, categoryType: TodoCategory?) {
        guard let todoCategory = categoryType else {
            return
        }
        let todoDetailViewModel = TodoDetailViewModel(database: self.database)
        
        self.todoDetailViewController = TodoDetailViewController(pickTodo: pickTodo, todoCategory: todoCategory, todoDetailType: detailType, todoDetailViewModel: todoDetailViewModel, coordinator: self)
        
        guard let todoDetailViewController = todoDetailViewController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: todoDetailViewController)
        navigationController.modalPresentationStyle = .formSheet
        self.coordinatorController.present(navigationController, animated: false)
        
    }
    
    func dismissView() {
        self.todoDetailViewController?.dismiss(animated: true)
    }
}
