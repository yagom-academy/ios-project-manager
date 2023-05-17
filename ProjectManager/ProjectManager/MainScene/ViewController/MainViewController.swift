//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    
    private let todoTableView = UITableView()
    private let doingTableView = UITableView()
    private let doneTableView = UITableView()
    
    private var todoDatasource: UITableViewDiffableDataSource<TaskState, Task>?
    private var doingDatasource: UITableViewDiffableDataSource<TaskState, Task>?
    private var doneDatasource: UITableViewDiffableDataSource<TaskState, Task>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationViewUI()
        configureViewUI()
        configureTableViewUI()
    }
}

extension MainViewController {
    private func configureDelegate() {
        todoTableView.dataSource = todoDatasource
        doingTableView.dataSource = doingDatasource
        doneTableView.dataSource = doneDatasource
    }
    
    private func configureDatasource() {
    }
}

// MARK: UI
extension MainViewController {
    private func configureNavigationViewUI() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
    }
    
    private func configureViewUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableViewUI() {
        let tableStackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        
        tableStackView.translatesAutoresizingMaskIntoConstraints = false
        tableStackView.spacing = 0
        tableStackView.distribution = .fillEqually
        
        view.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
