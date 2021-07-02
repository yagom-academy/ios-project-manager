//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ProjectManagerViewController: UIViewController {

    let projectManagerStackView = ProjectManagerStackView()
    
    let toDoTableView = UITableView()
    let doingTableView = UITableView()
    let doneTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "소개팅 필승 공략"
        
        configureStackView()
        configureProjectManagerTableView()
        
        toDoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }
    
    private func configureProjectManagerTableView() {
        projectManagerStackView.addArrangedSubview(toDoTableView)
        projectManagerStackView.addArrangedSubview(doingTableView)
        projectManagerStackView.addArrangedSubview(doneTableView)
        
        toDoTableView.tableFooterView = UIView(frame: .zero)
        doingTableView.tableFooterView = UIView(frame: .zero)
        doneTableView.tableFooterView = UIView(frame: .zero)
        
        toDoTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doingTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
        doneTableView.register(ProjectManagerTableViewCell.self, forCellReuseIdentifier: ProjectManagerTableViewCell.identifier)
    }
}

// MARK: -StackView AutoLayout
extension ProjectManagerViewController {
    private func configureStackView() {
        view.addSubview(projectManagerStackView)
        
        NSLayoutConstraint.activate([
            projectManagerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectManagerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            projectManagerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectManagerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
