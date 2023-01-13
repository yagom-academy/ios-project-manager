//
//  ProjectManager - ViewController.swift
//  ProjectManager
//
//  Created by 애쉬 on 2023/01/11.
//

import UIKit

final class MainViewController: UIViewController {
    enum TodoSection: Hashable {
        case todo
        case doing
        case done
    }
    
    private let tableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.backgroundColor = UIColor.systemGray5
        return stackView
    }()
    
    private let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private let doingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private let doneTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        return tableView
    }()
    
    private typealias Snapshot = NSDiffableDataSourceSnapshot<TodoSection, TodoModel>
    
    private typealias DataSource = UITableViewDiffableDataSource<TodoSection, TodoModel>
    
    private lazy var todoDataSource: DataSource = configureDataSource(of: todoTableView)
    private lazy var doingDataSource: DataSource = configureDataSource(of: doingTableView)
    private lazy var doneDataSource: DataSource = configureDataSource(of: doneTableView)
    
    private var todoModels: [TodoModel] = []
    private var doingModels: [TodoModel] = []
    private var doneModels: [TodoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        configureNavagationBar()
        configureTodoView()
        applyAllSnapshot()
    }
    
    private func configureNavagationBar() {
        self.navigationItem.title = "Project Manager"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(showAddToDoView))
    }
    
    @objc private func showAddToDoView() {}
    
    private func configureTodoView() {
        let tableviews = [todoTableView, doingTableView, doneTableView]
        
        tableviews.forEach {
            $0.estimatedRowHeight = 150
            $0.rowHeight = UITableView.automaticDimension
            $0.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
            tableStackView.addArrangedSubview($0)
        }
        
        self.view.addSubview(tableStackView)
        
        NSLayoutConstraint.activate([
            tableStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureDataSource(of tableView: UITableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier,
                                                     for: indexPath) as? TodoTableViewCell
            
            cell?.configureContent(with: todo)
            return cell
        }
        
        return dataSource
    }
    
    private func applyAllSnapshot() {
        applyTodoSnapshot()
        applyDoingSnapshot()
        applyDoneSnapshot()
    }
    
    private func applyTodoSnapshot() {
        var todoSnapshot = Snapshot()
        todoSnapshot.appendSections([.todo])
        todoSnapshot.appendItems(todoModels)
        self.todoDataSource.apply(todoSnapshot)
    }
    
    private func applyDoingSnapshot() {
        var doingSnapshot = Snapshot()
        doingSnapshot.appendSections([.doing])
        doingSnapshot.appendItems(doingModels)
        self.doingDataSource.apply(doingSnapshot)
    }
    
    private func applyDoneSnapshot() {
        var doneSnapshot = Snapshot()
        doneSnapshot.appendSections([.done])
        doneSnapshot.appendItems(doneModels)
        self.doneDataSource.apply(doneSnapshot)
    }
}
