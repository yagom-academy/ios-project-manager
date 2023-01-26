//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    private let todoViewController = TaskViewController(type: .todo)
    private let doingViewController = TaskViewController(type: .doing)
    private let doneViewController = TaskViewController(type: .done)
    
    enum Constant {
        static let navigationTitle = "Project Manager"
        static let stackViewSpacing: CGFloat = 10
        static let preferredAddViewContentSize: CGFloat = 650
    }

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = Constant.stackViewSpacing
        stackView.backgroundColor = .systemGray4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationItem()
    }

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        configureChildViewControllers()
        configureConstraints()
    }

    private func configureChildViewControllers() {
        todoViewController.willMove(toParent: self)
        doingViewController.willMove(toParent: self)
        doneViewController.willMove(toParent: self)

        stackView.addArrangedSubview(todoViewController.view)
        stackView.addArrangedSubview(doingViewController.view)
        stackView.addArrangedSubview(doneViewController.view)

        self.addChild(todoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)

        todoViewController.didMove(toParent: self)
        doingViewController.didMove(toParent: self)
        doneViewController.didMove(toParent: self)
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureNavigationItem() {
        navigationItem.title = Constant.navigationTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddProjectView))
    }

    @objc private func showAddProjectView() {
        let addProjectViewController = AddProjectViewController()
        addProjectViewController.delegate = self
        let secondNavigationController = UINavigationController(rootViewController: addProjectViewController)
        secondNavigationController.modalPresentationStyle = .formSheet
        self.present(secondNavigationController, animated: true)
    }
    
    private func updateTodoTask(with task: Task) {
        todoViewController.filteredTasks.append(task)
    }
}

extension ProjectsViewController: TaskAddDelegate {
    func taskDidAdded(_ task: Task) {
        updateTodoTask(with: task)
    }
}
