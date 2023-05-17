//
//  ProjectManager - TodoListViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class TodoListViewController: UIViewController {
    
    private let todoTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        configureNavigationBar()
    }
    
    private func setUpTableView() {
        view.backgroundColor = .white
        view.addSubview(todoTableView)
        let safeArea = view.safeAreaLayoutGuide
        
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    private func configureNavigationBar() {
        let title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        
        navigationItem.title = title
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc func plusButtonTapped() {
        let todoViewModel = TodoViewModel()
        let todoView = TodoView(viewModel: todoViewModel)
        let plusTodoViewController = PlusTodoViewController(todoView: todoView, todoViewModel: todoViewModel)
        
        present(plusTodoViewController, animated: false)
    }
}
