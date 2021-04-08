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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTableView.backgroundColor = .systemGroupedBackground
        doingTableView.backgroundColor = .systemGroupedBackground
        doneTableView.backgroundColor = .systemGroupedBackground
        
        configureNavigationBar()
        configureMainView()
        registerCell()
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
