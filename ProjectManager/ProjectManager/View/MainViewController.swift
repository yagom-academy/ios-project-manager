//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {
    private let taskStackView = UIStackView()
    private let toDoViewController = ToDoViewController()
    private let doingViewController = DoingViewController()
    private let doneViewController = DoneViewController()

    private var toDoView: UIView!
    private var doingView: UIView!
    private var doneView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMainView()
        setupTaskStackView()
        setupConstraint()
    }

    private func setupNavigationBar() {
        self.navigationItem.title = "Project Manager"
        let addButtonImage = UIImage(systemName: "plus")
        let rightButton = UIBarButtonItem(
          image: addButtonImage,
          style: .done,
          target: self,
          action: nil
        )
        navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    private func setupMainView() {
        addChild(toDoViewController)
        addChild(doingViewController)
        addChild(doneViewController)

        toDoView = toDoViewController.view
        doingView = doingViewController.view
        doneView = doneViewController.view

        view.addSubview(taskStackView)
    }

    private func setupTaskStackView() {
        taskStackView.addArrangedSubview(toDoView)
        taskStackView.addArrangedSubview(doingView)
        taskStackView.addArrangedSubview(doneView)

        taskStackView.axis = .horizontal
        taskStackView.distribution = .fillEqually
        taskStackView.backgroundColor = .systemGray
        taskStackView.spacing = 10
    }

    private func setupConstraint() {
        taskStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: view.topAnchor),
            taskStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            taskStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

