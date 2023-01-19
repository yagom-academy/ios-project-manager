//  ProjectManager - ToDoListViewController.swift
//  created by zhilly on 2023/01/16

import UIKit

class ToDoListViewController: UIViewController {
    enum Schedule: Hashable {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Schedule, ToDo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ToDo>
    
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
    
    private lazy var dataSource: DataSource = {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ToDoCell.reuseIdentifier,
                for: indexPath
            ) as? ToDoCell else { return UITableViewCell() }
            
            cell.configure(title: item.title, body: item.body, deadline: item.deadline)
            
            return cell
        }
        
        return dataSource
    }()
    
    private var snapshot: Snapshot?
    
    init(status: ToDoState, viewModel: ToDoListViewModel) {
        self.status = status
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        setupView()
        setupViewModel()
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
    
    private func setupViewModel() {
        viewModel.model.bind { item in
            self.appendData(item: item)
            
            var currentSnapshot = Snapshot()
            currentSnapshot.appendSections([.main])
            currentSnapshot.appendItems(item)
            
            self.snapshot = currentSnapshot
            
            self.tableView.reloadData()
        }
    }
    
    private func appendData(item: [ToDo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Schedule, ToDo>()

        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        dataSource.apply(snapshot)
    }
    
    private func deleteToDo(indexPath: Int) {
        var currentSnapshot = dataSource.snapshot()
        guard let item = viewModel.fetchToDo(index: indexPath) else { return }
        
        currentSnapshot.deleteItems([item])
        dataSource.apply(currentSnapshot)
        viewModel.delete(indexPath: indexPath)
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ToDoHeaderView(status: self.status, count: self.viewModel.model.value.count)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editToDoViewController = EditToDoViewController(viewModel: viewModel,
                                                            indexPath: indexPath.item)
        
        let navigationController = UINavigationController(rootViewController: editToDoViewController)
        
        tableView.deselectRow(at: indexPath, animated: true)
        present(navigationController, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: nil) { [weak self] (_, _, success) in
            if self?.viewModel.fetchToDo(index: indexPath.item) != nil {
                self?.deleteToDo(indexPath: indexPath.item)
                self?.tableView.reloadData()
                success(true)
            } else {
                success(false)
            }
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
