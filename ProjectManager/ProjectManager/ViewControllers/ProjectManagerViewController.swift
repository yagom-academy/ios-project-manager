//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let registerViewController = RegisterViewController()
    let todoTableViewController = TODOTableViewController()
    let doingTableViewController = DOINGTableViewController()
    let doneTableViewController = DONETableViewController()

    let stackView: UIStackView = {
        let myStackView = UIStackView()
        myStackView.alignment = .fill
        myStackView.axis = .horizontal

        return myStackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButton = UIBarButtonItem.init(barButtonSystemItem: .add,
                                                  target: self,
                                                  action: #selector(buttonPressed(_:)))

        view.backgroundColor = .white
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = rightBarButton

        view.addSubview(stackView)
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

            todoTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            doingTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            doneTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        ])
    }

    @objc func buttonPressed(_ sender: Any) {
        let navigationController = UINavigationController(rootViewController: registerViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
}
