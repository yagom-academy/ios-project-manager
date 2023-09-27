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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.backgroundColor = .systemGray5
        
        return stackView
    }()
    
    private var tableViewData: [UITableView: [Int: Int]] = [:]
    private var todoItems = [ProjectManager]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        setUpBarButtonItem()
        configureUI()
        setUpTableViewLayout()
        setUpTableView()
    }
    
    private func setUpViewController() {
        view.backgroundColor = .systemBackground
        title = "Project Manager"
    }
    
    private func configureUI() {
        stackView.addArrangedSubview(todoTableView)
        stackView.addArrangedSubview(doingTableView)
        stackView.addArrangedSubview(doneTableView)
        
        view.addSubview(stackView)
    }

    private func setUpBarButtonItem() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func addButton() {
        let addTODOView = AddTODOViewController()
        let navigationController = UINavigationController(rootViewController: addTODOView)
        let backgroundView = UIView(frame: view.bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        addTODOView.view.sendSubviewToBack(backgroundView)
        addTODOView.delegate = self
    
        present(navigationController, animated: true)
    }
    
    private func setUpTableViewLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpTableView() {
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.register(ListTitleCell.self, forCellReuseIdentifier: "listTitleCell")
        todoTableView.register(DescriptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableViewData[todoTableView] = [0:1, 1:2]
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.register(ListTitleCell.self, forCellReuseIdentifier: "listTitleCell")
        doneTableView.register(DescriptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableViewData[doingTableView] = [0:1, 1:2]
        
        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.register(ListTitleCell.self, forCellReuseIdentifier: "listTitleCell")
        doneTableView.register(DescriptionCell.self, forCellReuseIdentifier: "descriptionCell")
        tableViewData[doneTableView] = [0:1, 1:2]
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (tableView, section) {
        case (todoTableView, 0):
            return 1
        
        case (todoTableView, 1):
            return todoItems.count
            
        case (doingTableView, 0):
            return 1
        case (doingTableView, 1):
          return 2
            
        case (doneTableView, 0):
            return 1
        case (doneTableView, 1):
          return 2
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (tableView, indexPath.section) {
        case (todoTableView, 0):
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: "listTitleCell", for: indexPath) as? ListTitleCell else { return UITableViewCell() }
            
            listCell.setModel(title: "TODO", count: todoItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
            
        case (todoTableView, 1):
            guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
            
            let todoItem = todoItems[indexPath.row]
            descriptionCell.setModel(title: todoItem.title, body: todoItem.body, date: todoItem.date)
            return descriptionCell
            
        case (doingTableView, 0):
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: "listTitleCell", for: indexPath) as? ListTitleCell else { return UITableViewCell() }
            
            listCell.setModel(title: "DOING", count: 2)
            listCell.backgroundColor = .systemGray5
            return listCell
            
        case (doingTableView, 1):
            guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
            
            return descriptionCell
            
        case (doneTableView, 0):
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: "listTitleCell", for: indexPath) as? ListTitleCell else { return UITableViewCell() }
            
            listCell.setModel(title: "DONE", count: 3)
            listCell.backgroundColor = .systemGray5
            return listCell
            
        case (doneTableView, 1):
            guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
            
            return descriptionCell
            
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: AddTodoDelegate {
    func didAddTodoItem(title: String, body: String, date: Date) {
        DataManager.shared.addTodoItem(title: title, body: body, date: date)
        todoItems = DataManager.shared.leadTodoItem()
        todoTableView.reloadData()
    }
}
