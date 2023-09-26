//
//  ProjectManager - MainViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

final class MainViewController: UIViewController {
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray5
        
        return tableView
    }()
    
    private var tableViewData: [UITableView: [Int: Int]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        configureUI()
        setUpTableViewLayout()
        setUpTableView()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        title = "Project Manager"
    }
    
    private func configureUI() {
        view.addSubview(todoTableView)
        view.addSubview(doingTableView)
        view.addSubview(doneTableView)
    }
    
    private func setUpTableViewLayout() {
        let tableViewWidth = view.bounds.width / 3.0
        
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doingTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doingTableView.leadingAnchor.constraint(equalTo: todoTableView.trailingAnchor),
            doingTableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
            doingTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doneTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doneTableView.leadingAnchor.constraint(equalTo: doingTableView.trailingAnchor),
            doneTableView.widthAnchor.constraint(equalToConstant: tableViewWidth),
            doneTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            doneTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewData[todoTableView] = [0:1, 1:2]
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewData[doingTableView] = [0:1, 1:2]
        
        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewData[doneTableView] = [0:1, 1:2]
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowInSection = tableViewData[tableView]?[section] {
            return rowInSection
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch (tableView, indexPath.section) {
        case (todoTableView, 0):
            cell.textLabel?.text = "TODO"
            cell.backgroundColor = .systemGray5
        case (todoTableView, 1):
            cell.textLabel?.text = "1"
            
        case (doingTableView, 0):
            cell.textLabel?.text = "Doing"
            cell.backgroundColor = .systemGray5
        case (doingTableView, 1):
            cell.textLabel?.text = "2"
            
        case (doneTableView, 0):
            cell.textLabel?.text = "Done"
            cell.backgroundColor = .systemGray5
        case (doneTableView, 1):
            cell.textLabel?.text = "3"
            
        default:
            break
        }
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
