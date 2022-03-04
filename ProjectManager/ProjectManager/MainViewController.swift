//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {

    let todoViewController = ProjectListViewController()
    let doingViewController = ProjectListViewController()
    let doneViewController = ProjectListViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureListViewLayout()
    }

    func configureNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        
        navigationItem.rightBarButtonItem = addButton
        navigationItem.title = "Project Manager"
        navigationController?.navigationBar.barTintColor = .systemGray6
    }
    
    @objc func addTodo() {
        let taskViewController = TaskViewController()
        taskViewController.delegate = todoViewController
        taskViewController.popoverPresentationController?.sourceView = view
        taskViewController.popoverPresentationController?.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0)
        taskViewController.popoverPresentationController?.permittedArrowDirections = []
        
        let popoverController = UINavigationController(rootViewController: taskViewController)
        
        present(popoverController, animated: true, completion: nil)
    }
    
    func configureListViewLayout() {
        let todoTableView = todoViewController.tableView
        let doingTableView = doingViewController.tableView
        let doneTableView = doneViewController.tableView
        let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray4
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
