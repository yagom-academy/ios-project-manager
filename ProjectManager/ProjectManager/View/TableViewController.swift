//
//  TableViewController.swift
//  ProjectManager
//
//  Created by 무리 on 2023/05/23.
//

import UIKit

class TableViewController: UIViewController {
    private let listViewModel = ListViewModel()
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.backgroundColor = .systemGray3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubviews()
        configureConstraints()
        configureNavigation()
    }
    
    private func configureSubviews() {
        view.addSubview(tableStackView)
        tableStackView.addArrangedSubview(todoTableView)
        tableStackView.addArrangedSubview(doingTableView)
        tableStackView.addArrangedSubview(doneTableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        todoTableView.dataSource = self
        doingTableView.dataSource = self
        doneTableView.dataSource = self
    }
    
    private func configureNavigation() {
        title = NameSpace.projectName
        
        let addProjectButton = UIBarButtonItem(barButtonSystemItem: .add,
                                               target: self,
                                               action: #selector(addProject))
        
        navigationItem.rightBarButtonItem = addProjectButton
    }
    
    @objc
    private func addProject() {
        let addProjectViewController = AddProjectViewController()
        addProjectViewController.modalPresentationStyle = .formSheet
        let modalViewWithNavigation = UINavigationController(rootViewController: addProjectViewController)
        navigationController?.present(modalViewWithNavigation, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case todoTableView:
            let count = listViewModel.todoList.filter({ $0.state == .Todo }).count
            
            return count
        case doingTableView:
            let count = listViewModel.todoList.filter({ $0.state == .Doing }).count
            
            return count
        case doneTableView:
            let count = listViewModel.todoList.filter({ $0.state == .Done }).count
            
            return count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case todoTableView:
            guard let cell = todoTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.todoList.filter({ $0.state == .Todo })[indexPath.row])
            
            return cell
            
        case doingTableView:
            guard let cell = doingTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.todoList.filter({ $0.state == .Doing })[indexPath.row])
            
            return cell
            
        case doneTableView:
            guard let cell = doneTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier) as? TableViewCell else {
                return TableViewCell()
            }
            listViewModel.configureCell(to: cell, with: listViewModel.todoList.filter({ $0.state == .Done })[indexPath.row])
            
            return cell
        default:
            return TableViewCell()
        }
    }
}

private enum NameSpace {
    static let projectName = "Project Manager"
}
