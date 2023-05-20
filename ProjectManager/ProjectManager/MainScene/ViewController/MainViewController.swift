//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

protocol TaskDelegate: AnyObject {
    func saveTask(_ task: Task)
}

final class MainViewController: UIViewController {
    
    private let viewModel = MainViewModel()
    
    private let todoViewController = ListViewController(taskState: .todo)
    private let doingViewController = ListViewController(taskState: .doing)
    private let doneViewController = ListViewController(taskState: .done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
        configureChildViewControllerUI()
    }
    
    @objc private func didTapAddButton() {
        let todoViewController = TodoViewController()
        let navigationController = UINavigationController(rootViewController: todoViewController)
        
        todoViewController.taskDelegate = self
        
        self.present(navigationController, animated: true)
    }
}

extension MainViewController: TaskDelegate {
    func saveTask(_ task: Task) {
        viewModel.appendTask(task)
        
        let tasks = viewModel.filterTasks(by: .todo)
        todoViewController.applySnapshot(by: tasks)
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    private func configureViewUI() {
        self.view.backgroundColor = .systemGray5
    }
    
    private func configureChildViewControllerUI() {
        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)
        
        let stackView = UIStackView()
        
        children.forEach { childViewController in
            stackView.addArrangedSubview(childViewController.view)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray3
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
