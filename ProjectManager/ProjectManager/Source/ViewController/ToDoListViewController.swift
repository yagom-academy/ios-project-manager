//  ProjectManager - ToDoListViewController.swift
//  created by zhilly on 2023/01/16

import UIKit

final class ToDoListViewController: UIViewController {
    
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
            
            if item.isOverDeadline {
                cell.changeDeadlineColor(.systemRed)
            } else {
                cell.changeDeadlineColor(.black)
            }
            
            return cell
        }
        
        return dataSource
    }()
    
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
        switch status {
        case .toDo:
            viewModel.todoModel.bind { item in
                self.appendData(item: item)
                self.tableView.reloadData()
            }
        case .doing:
            viewModel.doingModel.bind { item in
                self.appendData(item: item)
                self.tableView.reloadData()
            }
        case .done:
            viewModel.doneModel.bind { item in
                self.appendData(item: item)
                self.tableView.reloadData()
            }
        }
    }
    
    private func appendData(item: [ToDo]) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(item)
        dataSource.apply(snapshot)
    }
    
    private func deleteToDo(indexPath: Int) {
        var currentSnapshot = dataSource.snapshot()
        guard let item = viewModel.fetchToDo(index: indexPath, state: self.status) else { return }
        
        currentSnapshot.deleteItems([item])
        dataSource.apply(currentSnapshot)
        viewModel.delete(indexPath: indexPath, state: self.status)
    }
    
    @objc
    private func updated() {
        appendData(item: self.viewModel.fetchList(state: self.status))
        self.tableView.reloadData()
    }
    
    private func updateState(indexPath: Int, state: ToDoState) {
        viewModel.updateStatus(indexPath: indexPath, currentState: self.status, changeState: state)
    }
}

extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ToDoHeaderView(status: self.status, count: self.viewModel.count(state: self.status))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editToDoViewController = EditToDoViewController(viewModel: viewModel,
                                                            indexPath: indexPath.item,
                                                            status: status)
        
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
            if self?.viewModel.fetchToDo(index: indexPath.item, state: self?.status ?? .toDo) != nil {
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
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let moveToTodo = UIAction(title: NSLocalizedString("Move To Todo", comment: ""),
                                  image: nil) { _ in
            self.updateState(indexPath: indexPath.item, state: .toDo)
        }
        let moveToDoing = UIAction(title: NSLocalizedString("Move To Doing", comment: ""),
                                   image: nil) { _ in
            self.updateState(indexPath: indexPath.item, state: .doing)
        }
        let moveToDone = UIAction(title: NSLocalizedString("Move To Done", comment: ""),
                                  image: nil) { _ in
            self.updateState(indexPath: indexPath.item, state: .done)
        }
        
        let menu: UIMenu
        
        switch status {
        case .toDo:
            menu = UIMenu(children: [moveToDoing, moveToDone])
        case .doing:
            menu = UIMenu(children: [moveToTodo, moveToDone])
        case .done:
            menu = UIMenu(children: [moveToTodo, moveToDoing])
        }
        
        return UIContextMenuConfiguration(actionProvider: { _ in
            return menu
        })
    }
}
