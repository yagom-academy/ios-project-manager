//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class MainViewController: UIViewController {
    
    private var todoTableView = UITableView(frame: .zero, style: .grouped)
    private var doingTableView = UITableView(frame: .zero, style: .grouped)
    private var doneTableView = UITableView(frame: .zero, style: .grouped)
    
    private let todoHeaderView = HeaderView(Todos.common.todoList.count, title: String.todo)
    private let doingHeaderView = HeaderView(Todos.common.doingList.count, title: String.doing)
    private let doneHeaderView = HeaderView(Todos.common.doneList.count, title: String.done)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.backgroundColor = .systemGroupedBackground
        doingTableView.backgroundColor = .systemGroupedBackground
        doneTableView.backgroundColor = .systemGroupedBackground
        
        configureNavigationBar()
        configureMainView()
        registerCell()
        configureTableViewHeader()
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        todoTableView.dragDelegate = self
        todoTableView.dropDelegate = self
        
        doingTableView.dataSource = self
        doingTableView.delegate = self
        doingTableView.dragDelegate = self
        doingTableView.dropDelegate = self
        
        doneTableView.dataSource = self
        doneTableView.delegate = self
        doneTableView.dragDelegate = self
        doneTableView.dropDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadView"), object: nil)
            }
    
    @objc private func reloadTableView() {
            DispatchQueue.main.async {
                self.todoTableView.reloadData()
                self.doingTableView.reloadData()
                self.doneTableView.reloadData()
                self.reloadCountLabel()
            }
        }
        
        private func reloadCountLabel() {
            todoHeaderView.numberLabel.text = String(Todos.common.todoList.count)
            doingHeaderView.numberLabel.text = String(Todos.common.doingList.count)
            doneHeaderView.numberLabel.text = String(Todos.common.doneList.count)
        }
    
    private func configureNavigationBar() {
        navigationController?.isToolbarHidden = false
        navigationItem.rightBarButtonItem = .init(barButtonSystemItem: .add, target: self, action: #selector(touchUpAddButton))
        navigationItem.title = String.navigationBarTitle
    }
    
    @objc private func touchUpAddButton() {
        showDetailView()
        configureMainView()
    }
    
    private func showDetailView(isEdit: Bool = false, todo: Todo? = nil, tableView: String? = nil, index: Int = 0) {
        let detailView = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailView)
        detailView.tableViewName = tableView
        detailView.index = index
        detailView.isEdit = isEdit
        detailView.todo = todo
        present(navigationController, animated: true, completion: nil)
    }
    
    private func configureMainView() {
        let stackView = UIStackView(arrangedSubviews: [todoTableView, doingTableView, doneTableView])
        let safeArea = view.safeAreaLayoutGuide
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray2
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    private func configureTableViewHeader() {
        todoTableView.tableHeaderView = todoHeaderView
        doingTableView.tableHeaderView = doingHeaderView
        doneTableView.tableHeaderView = doneHeaderView
    }
    
    private func registerCell() {
        todoTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        doingTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        doneTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        if tableView == todoTableView {
            cell.configure(Todos.common.todoList[indexPath.row])
            cell.determineColor(Todos.common.todoList[indexPath.row].deadline)
            return cell
        } else if tableView == doingTableView {
            cell.configure(Todos.common.doingList[indexPath.row])
            cell.determineColor(Todos.common.doingList[indexPath.row].deadline)
            return cell
        } else if tableView == doneTableView {
            cell.configure(Todos.common.doneList[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == todoTableView {
            return Todos.common.todoList.count
        } else if tableView == doingTableView {
            return Todos.common.doingList.count
        } else {
            return Todos.common.doneList.count
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == todoTableView {
            showDetailView(isEdit: true, todo: Todos.common.todoList[indexPath.row], tableView: String.todo, index: indexPath.row)
        } else if tableView == doingTableView {
            showDetailView(isEdit: true, todo: Todos.common.doingList[indexPath.row], tableView: String.doing, index: indexPath.row)
        } else {
            showDetailView(isEdit: true, todo: Todos.common.doneList[indexPath.row], tableView: String.done, index: indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        var tableViewName = String.empty
        if tableView == todoTableView {
            tableViewName = String.todo
        } else if tableView == doingTableView {
            tableViewName = String.doing
        } else {
            tableViewName = String.done
        }
        return Todos.common.dragItems(for: indexPath, from: tableViewName)
    }
}

extension MainViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        var tableViewName = String.empty
        var indexPath: IndexPath
        if let destinationIndexPath = coordinator.destinationIndexPath {
            indexPath = destinationIndexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            indexPath = IndexPath(row: row, section: section)
        }
        if tableView == todoTableView {
            tableViewName = String.todo
        } else if tableView == doingTableView {
            tableViewName = String.doing
        } else {
            tableViewName = String.done
        }
        Todos.common.dropItems(for: indexPath, from: tableViewName, dropItems: coordinator.items)
    }
}
