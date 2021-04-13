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
    
    private let todoHeaderView = HeaderView(Todos.common.todoList.count, title: State.todo.rawValue)
    private let doingHeaderView = HeaderView(Todos.common.doingList.count, title: State.doing.rawValue)
    private let doneHeaderView = HeaderView(Todos.common.doneList.count, title: State.done.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureMainView()
        registerCell()
        configureTableViewHeader()
        setDelegateAndDataSource()
        
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
        navigationItem.title = NavigationBar.title.rawValue
    }
    
    private func setDelegateAndDataSource() {
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
        
        todoTableView.backgroundColor = .systemGroupedBackground
        doingTableView.backgroundColor = .systemGroupedBackground
        doneTableView.backgroundColor = .systemGroupedBackground
        
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
    
    private func listForTableView(_ tableView: UITableView) -> [Todo]? {
        switch tableView {
        case todoTableView:
            return Todos.common.todoList
        case doingTableView:
            return Todos.common.doingList
        case doneTableView:
            return Todos.common.doneList
        default:
            return nil
        }
    }
    
    private func stateForTableView(_ tableView: UITableView) -> String? {
        switch tableView {
        case todoTableView:
            return State.todo.rawValue
        case doingTableView:
            return State.doing.rawValue
        case doneTableView:
            return State.done.rawValue
        default:
            return nil
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell,
              let list = listForTableView(tableView) else {
            return UITableViewCell()
        }
        
        cell.configure(list[indexPath.row])
        cell.determineColor(list[indexPath.row].deadline)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listForTableView(tableView)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == todoTableView {
            if editingStyle == .delete {
                Todos.common.todoList.remove(at: indexPath.row)
                reloadCountLabel()
            }
        } else if tableView == doingTableView {
            if editingStyle == .delete {
                Todos.common.doingList.remove(at: indexPath.row)
                reloadCountLabel()
            }
        } else {
            if editingStyle == .delete {
                Todos.common.doneList.remove(at: indexPath.row)
                reloadCountLabel()
            }
        }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let list = listForTableView(tableView),
              let state = stateForTableView(tableView) else {
            return

        }
        showDetailView(isEdit: true, todo: list[indexPath.row], tableView: state, index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {

        guard let state = stateForTableView(tableView) else {
            return []
        }
        
        return Todos.common.dragItems(for: indexPath, from: state)
    }
}

extension MainViewController: UITableViewDropDelegate {
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        guard let state = stateForTableView(tableView) else {
            return
        }
        var indexPath: IndexPath
        if let destinationIndexPath = coordinator.destinationIndexPath {
            indexPath = destinationIndexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            indexPath = IndexPath(row: row, section: section)
        }
        Todos.common.dropItems(for: indexPath, from: state, dropItems: coordinator.items)
    }
}
