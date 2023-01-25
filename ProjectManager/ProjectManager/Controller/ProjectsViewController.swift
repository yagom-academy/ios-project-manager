//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectsViewController: UIViewController {

    enum Constant {
        static let navigationTitle = "Project Manager"
        static let stackViewSpacing: CGFloat = 10
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
        let todoViewController = TaskViewController(type: .todo)
        let doingViewController = TaskViewController(type: .doing)
        let doneViewController = TaskViewController(type: .done)

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
        let secondNavigationController = UINavigationController(rootViewController: addProjectViewController)
        self.present(secondNavigationController, animated: true)
    }
}
