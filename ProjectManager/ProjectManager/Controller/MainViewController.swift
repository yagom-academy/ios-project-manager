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
    
    // DB 구현 후, fetchData()를 필터링해 써서 배열을 1개만 둘 예정
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
            $0.delegate = self
            $0.estimatedRowHeight = 150
            $0.rowHeight = UITableView.automaticDimension
            $0.register(TodoTableViewCell.self,
                        forCellReuseIdentifier: TodoTableViewCell.identifier)
            $0.register(TodoHeaderView.self,
                        forHeaderFooterViewReuseIdentifier: TodoHeaderView.identifier)
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TodoHeaderView.identifier) as? TodoHeaderView else {
            return UIView()
        }
        
        switch tableView {
        case todoTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.todo)
            headerView.updateCount(todoModels.count)
        case doingTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.doing)
            headerView.updateCount(doingModels.count)
        case doneTableView:
            headerView.configureContent(of: TodoModel.TodoStatus.done)
            headerView.updateCount(doneModels.count)
        default:
            break
        }
        
        return headerView
    }
}
