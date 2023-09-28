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
    private var doingItems = [ProjectManager]()
    private var doneItems = [ProjectManager]()
    
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
    
    private func moveToDoing(_ item: ProjectManager) {
        if let index = todoItems.firstIndex(where: { $0 == item }) {
            todoItems.remove(at: index)
        } else if let index = doneItems.firstIndex(where: { $0 == item }) {
            doneItems.remove(at: index)
        }
        
        doingItems.append(item)
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
        
    }
    
    private func moveToDone(_ item: ProjectManager) {
        if let index = todoItems.firstIndex(where: { $0 == item }) {
            todoItems.remove(at: index)
        } else if let index = doingItems.firstIndex(where: { $0 == item }) {
            doingItems.remove(at: index)
        }
        
        doneItems.append(item)
        
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private func moveToTodo(_ item: ProjectManager) {
        if let index = doingItems.firstIndex(where: { $0 == item }) {
            doingItems.remove(at: index)
        } else if let index = doneItems.firstIndex(where: { $0 == item }) {
            doneItems.remove(at: index)
        }
        
        todoItems.append(item)
        
        todoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
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
            return doingItems.count
            
        case (doneTableView, 0):
            return 1
        case (doneTableView, 1):
            return doneItems.count
            
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
            
            listCell.setModel(title: "DOING", count: doingItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
            
        case (doingTableView, 1):
            guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
            
            let doingItem = doingItems[indexPath.row]
            descriptionCell.setModel(title: doingItem.title, body: doingItem.body, date: doingItem.date)
            return descriptionCell
            
        case (doneTableView, 0):
            guard let listCell = tableView.dequeueReusableCell(withIdentifier: "listTitleCell", for: indexPath) as? ListTitleCell else { return UITableViewCell() }
            
            listCell.setModel(title: "DONE", count: doneItems.count)
            listCell.backgroundColor = .systemGray5
            return listCell
            
        case (doneTableView, 1):
            guard let descriptionCell = todoTableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath) as? DescriptionCell else { return UITableViewCell() }
            
            let doneItem = doneItems[indexPath.row]
            descriptionCell.setModel(title: doneItem.title, body: doneItem.body, date: doneItem.date)
            return descriptionCell
            
        default:
            return UITableViewCell()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell: ProjectManager
        switch (tableView, indexPath.section) {
        case (todoTableView, 1):
            selectedCell = todoItems[indexPath.row]
        case (doingTableView, 1):
            selectedCell = doingItems[indexPath.row]
        case (doneTableView, 1):
            selectedCell = doneItems[indexPath.row]
        default:
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        switch tableView {
        case todoTableView:
            let moveToDoingAction = UIAlertAction(title: "Move to DOING", style: .default) { [weak self] _ in
                self?.moveToDoing(selectedCell)
            }
            let moveToDoneAction = UIAlertAction(title: "Move to DONE", style: .default) { [weak self] _ in
                self?.moveToDone(selectedCell)
            }
            alertController.addAction(moveToDoingAction)
            alertController.addAction(moveToDoneAction)
            
        case doingTableView:
            let moveToTodoAction = UIAlertAction(title: "Move to TODO", style: .default) { [weak self] _ in
                self?.moveToTodo(selectedCell)
            }
            let moveToDoneAction = UIAlertAction(title: "Move to DONE", style: .default) { [weak self] _ in
                self?.moveToDone(selectedCell)
            }
            alertController.addAction(moveToTodoAction)
            alertController.addAction(moveToDoneAction)
            
        case doneTableView:
            let moveToTodoAction = UIAlertAction(title: "Move to TODO", style: .default) { [weak self] _ in
                self?.moveToTodo(selectedCell)
            }
            let moveToDoingAction = UIAlertAction(title: "Move to DOING", style: .default) { [weak self] _ in
                self?.moveToDoing(selectedCell)
            }
            alertController.addAction(moveToTodoAction)
            alertController.addAction(moveToDoingAction)
            
        default:
            break
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = tableView
            popoverPresentationController.sourceRect = tableView.rectForRow(at: indexPath)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: AddTodoDelegate {
    func didAddTodoItem(title: String, body: String, date: Date) {
        DataManager.shared.addTodoItem(title: title, body: body, date: date)
        let newTodoItem = ProjectManager(title: title, body: body, date: date)
        todoItems.append(newTodoItem)
        todoTableView.reloadData()
    }
}
