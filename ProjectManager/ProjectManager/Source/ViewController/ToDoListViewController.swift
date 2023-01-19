//  ProjectManager - ToDoListViewController.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoListViewController: UIViewController {
    enum Schedule: Hashable {
        case main
    }
    
    private let status: ToDoState
    let viewModel: ToDoListViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50
        tableView.register(ToDoCell.self, forCellReuseIdentifier: ToDoCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var dataSource: UITableViewDiffableDataSource = {
        let dataSource = UITableViewDiffableDataSource<Schedule, ToDo>(
            tableView: tableView
        ) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ToDoCell.reuseIdentifier,
                for: indexPath
            ) as? ToDoCell else { return UITableViewCell() }
            
            cell.configure(title: item.title, body: item.body, deadline: item.deadline)
            
            return cell
        }
        
        return dataSource
    }()
    
    init(status: ToDoState, viewModel: ToDoListViewModel) {
        self.status = status
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        tableView.delegate = self
        setupView()
        
        viewModel.model.bind { item in
            self.appendData(item: item)
            self.tableView.reloadData()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func appendData(item: [ToDo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Schedule, ToDo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        
        dataSource.apply(snapshot)
    }
    
    func addToDo(item: ToDo) {
        viewModel.addToDo(item: item)
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ToDoHeaderView(status: self.status, count: self.viewModel.model.value.count)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let toDo = dataSource.itemIdentifier(for: indexPath) else { return }
        
        // guard let toDo = viewModel.fetchToDo(index: indexPath.item) else { return }
        let editToDoViewController = EditToDoViewController(viewModel: viewModel, toDo: toDo)
        
        let navigationController = UINavigationController(rootViewController: editToDoViewController)
        
        tableView.deselectRow(at: indexPath, animated: true)
        present(navigationController, animated: true)
    }
}
