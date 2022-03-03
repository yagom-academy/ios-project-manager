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
        setupNavigation()
        setupMainView()
        setupTaskStackView()
        setupConstraint()
    }

    private func setupNavigation() {
        navigationItem.title = "Project Manager"
        let addButtonImage = UIImage(systemName: "plus")
        let rightButton = UIBarButtonItem(
          image: addButtonImage,
          style: .done,
          target: self,
          action: #selector(showEditView)
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

    }

    private func setupTaskStackView() {
        view.addSubview(taskStackView)
        taskStackView.addArrangedSubview(toDoView)
        taskStackView.addArrangedSubview(doingView)
        taskStackView.addArrangedSubview(doneView)

        taskStackView.axis = .horizontal
        taskStackView.distribution = .fillEqually
        taskStackView.backgroundColor = .lightGray
        taskStackView.spacing = 10
    }

    private func setupConstraint() {
        taskStackView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            taskStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            taskStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            taskStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            taskStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    @objc func showEditView() {
        let editView = UINavigationController(rootViewController:  EditViewController())
        editView.modalPresentationStyle = .automatic
        self.present(editView, animated: true)
    }
}

