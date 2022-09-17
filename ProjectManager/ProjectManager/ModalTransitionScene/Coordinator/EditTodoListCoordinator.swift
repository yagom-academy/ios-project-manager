//
//  EditTodoListCoordinator.swift
//  ProjectManager
//
//  Created by 이원빈 on 2022/09/15.
//

import UIKit

final class EditTodoListCoordinator: Coordinator {
    var viewModel: TodoListViewModel
    var category: String
    var index: Int
    
    init(viewModel: TodoListViewModel, category: String, index: Int) {
        self.viewModel = viewModel
        self.category = category
        self.index = index
    }
    
    func start() -> UIViewController {
        let editVC = EditTodoListViewController(viewModel: viewModel,
                                                category: category,
                                                index: index)
        let navCon = UINavigationController(
            rootViewController: editVC
        )
        navCon.modalPresentationStyle = .formSheet
        return navCon
    }
}
