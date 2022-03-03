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
        setupMainView()
        setupTaskStackView()
        setupConstraint()
    }

    private func setupMainView() {
        self.addChild(toDoViewController)
        self.addChild(doingViewController)
        self.addChild(doneViewController)

        self.toDoView = toDoViewController.view
        self.doingView = doingViewController.view
        self.doneView = doneViewController.view

        self.view.addSubview(taskStackView)
    }

    private func setupTaskStackView() {
        taskStackView.addArrangedSubview(toDoView)
        taskStackView.addArrangedSubview(doingView)
        taskStackView.addArrangedSubview(doneView)

        taskStackView.axis = .horizontal
        taskStackView.distribution = .fillEqually
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

