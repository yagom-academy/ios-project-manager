//
//  ProjectManager - ToDoListViewContorller.swift
//  Created by goat.
//  Copyright © goat. All rights reserved.
//

import UIKit

class ToDoListViewContorller: UIViewController, sendToDoListProtocol {
    
    private var toDoList: [ToDoList]?
    
    func sendTodoList(data: ToDoList) {
        toDoList?.append(data)
        toDoTableView.reloadData()
        doingTableView.reloadData()
        doneTableView.reloadData()
    }
    
    private let toDoStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    lazy var toDoTableView = createTableView(title: "TODO")
    lazy var doingTableView = createTableView(title: "DOING")
    lazy var doneTableView = createTableView(title: "DONE")
    
    private func createTableView(title: String) -> UITableView {
        let tableview = UITableView()
        tableview.backgroundColor = .systemGray6
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
        
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = title
        headerLabel.font = .systemFont(ofSize: 32,weight: .medium)
        headerLabel.textAlignment = .natural
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
        tableview.tableHeaderView = headerView
        
        return tableview
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoList = []
        configureNavigationBar()
        setTableView()
        configureViewUI()
    }
    
    // MARK: NavigationBar
    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        let plusButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = plusButton
    }
    
    @objc private func plusButtonTapped() {
        let toDoWriteViewController = ToDoWriteViewController()
        toDoWriteViewController.modalPresentationStyle = .formSheet
        
        toDoWriteViewController.delegate = self
        
        self.present(toDoWriteViewController, animated: true)
    }
    
    // MARK: TableView Setting
    private func setTableView() {
        toDoTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doingTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        doneTableView.register(ToDoTableViewCell.self, forCellReuseIdentifier: ToDoTableViewCell.identifier)
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        doingTableView.delegate = self
        doingTableView.dataSource = self
        
        doneTableView.delegate = self
        doneTableView.dataSource = self
    }
    
    // MARK: Autolayout
    private func configureViewUI() {
        view.backgroundColor = .white
        view.addSubview(toDoStackView)
        
        toDoStackView.addArrangedSubview(toDoTableView)
        toDoStackView.addArrangedSubview(doingTableView)
        toDoStackView.addArrangedSubview(doneTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        toDoStackView.translatesAutoresizingMaskIntoConstraints = false
        toDoTableView.translatesAutoresizingMaskIntoConstraints = false
        doingTableView.translatesAutoresizingMaskIntoConstraints = false
        doneTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toDoStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            toDoStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            toDoStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            toDoStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension ToDoListViewContorller: UITableViewDelegate {
}

extension ToDoListViewContorller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == toDoTableView {
            return toDoList?.count ?? 0
        } else {
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let toDoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ToDoTableViewCell", for: indexPath) as? ToDoTableViewCell,
              let toDoList = self.toDoList else { return UITableViewCell() }
        if tableView == toDoTableView {
            toDoTableViewCell.setUpLabel(toDoList: toDoList[indexPath.row])
        } else {
            
        }
        
        return toDoTableViewCell
    }
}
