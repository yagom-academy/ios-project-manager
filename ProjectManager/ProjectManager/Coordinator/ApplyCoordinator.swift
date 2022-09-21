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
    
    init(navigationController: UINavigationController) {
        self.coordinatorController = navigationController
    }
    
    func moveStart() {
        self.passAwayTodoListView()
    }
    
    private func passAwayTodoListView() {
        let todoViewController = TodoListViewController(coordinator: self)
        self.coordinatorController.pushViewController(todoViewController, animated: true)
    }
    
    func passAwayTodoDetailView() {
        
    }
    
    func dismissView() {
        self.todoDetailViewController?.dismiss(animated: true)
    }
}
