//
//  ProjectManager - ProjectManagerViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

//노티피케이션 센터를 만들어주었음
let didDismissPostProjectManagerViewController: Notification.Name = Notification.Name("DidDismissPostProjectManagerViewController")

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

    @objc func reloadData() {
        todoTableViewController.tableView.reloadData()
        todoTableViewController.countLabel.text = "\(TODOTableViewController.todoLists.count)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //야 노티피케이션 센터에 알림오면 나한테 알려줘~
        //만약에 알림을 받으면, 내가 self.reloadData 를 실행할거야~
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: didDismissPostProjectManagerViewController, object: nil)
        
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

            todoTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -10),
            doingTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3, constant: -10),
            doneTableViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        ])
    }

    @objc func buttonPressed(_ sender: Any) {
        let registerViewController = RegisterViewController()
        let navigationController = UINavigationController(rootViewController: registerViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
}
