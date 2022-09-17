//
//  CreateTodoListCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/15.
//

import UIKit

final class CreateTodoListCoordinator: Coordinator {
    var viewModel: TodoListViewModel

    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
    }
    
    func start() -> UIViewController {
        let createVC = CreateTodoListViewController(viewModel: viewModel)
        let navCon = UINavigationController(
            rootViewController: createVC
        )
        navCon.modalPresentationStyle = .formSheet
        return navCon
    }
}
