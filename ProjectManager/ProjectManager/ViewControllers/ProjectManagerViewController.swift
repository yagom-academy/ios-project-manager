//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let todoTableViewController = TODOTableViewController()
    let doingTableViewController = DOINGTableViewController()
    let doneTableViewController = DONETableViewController()

    let stackView: UIStackView = {
        let myStackView = UIStackView()

        myStackView.alignment = .fill
        myStackView.axis = .horizontal
        myStackView.spacing = 10
        
        return myStackView
    }()

    @objc func buttonPressed(_ sender: Any) {
        let registerViewController = RegisterViewController()
        let navigationController = UINavigationController(rootViewController: registerViewController)
        self.present(navigationController, animated: true, completion: nil)
    }

    @objc func reloadData() {
        todoTableViewController.tableView.reloadData()
        doingTableViewController.tableView.reloadData()
        doneTableViewController.tableView.reloadData()
        todoTableViewController.countLabel.text = "\(Task.todoList.count)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(buttonPressed(_:)))

        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: didDismissNotificationCenter, object: nil)
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = rightBarButton
        configureView()
    }
}

extension ProjectManagerViewController {

    func configureView() {
        view.addSubview(stackView)
        view.backgroundColor = .systemGray4
        stackView.addArrangedSubview(todoTableViewController.view)
        stackView.addArrangedSubview(doingTableViewController.view)
        stackView.addArrangedSubview(doneTableViewController.view)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        todoTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        doingTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        doneTableViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            todoTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -10),
            doingTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -10),
            doneTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        ])
    }
}
