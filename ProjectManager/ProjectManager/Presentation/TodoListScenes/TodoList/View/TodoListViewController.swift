//
//  TodoListViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/06.
//

import UIKit
import Combine

import SnapKit

final class TodoListViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, TodoListModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TodoListModel>
    
    private let viewModel: TodoListViewModel
    private lazy var todoListView = TodoListView(frame: self.view.bounds, tableViewDelegate: self)
    
    private var todoDataSource: DataSource?
    private var doingDataSource: DataSource?
    private var doneDataSource: DataSource?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: TodoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.todoItems.sink { [weak self] items in
            self?.applySnapshot(items: items, datasource: self?.todoDataSource)
        }
        .store(in: &cancellables)
        
        viewModel.doingItems.sink { [weak self] items in
            self?.applySnapshot(items: items, datasource: self?.doingDataSource)
        }
        .store(in: &cancellables)
        
        viewModel.doneItems.sink { [weak self] items in
            self?.applySnapshot(items: items, datasource: self?.doneDataSource)
        }
        .store(in: &cancellables)
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
        setupDataSource()
    }
    
    private func addSubviews() {
        view.addSubview(todoListView)
    }
    
    private func setupConstraint() {
        todoListView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Project Manager"
        
        let addAction = UIAction { [weak self] _ in
            self?.viewModel.addButtonDidTap()
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: addAction)
    }
    
    private func setupDataSource() {
        todoDataSource = DataSource(tableView: todoListView.todoTableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoTableViewCell.identifier,
                for: indexPath
            ) as? TodoTableViewCell
            
            cell?.setupData(with: itemIdentifier)
            
            return cell
        }
        
        doingDataSource = DataSource(tableView: todoListView.doingTableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoTableViewCell.identifier,
                for: indexPath
            ) as? TodoTableViewCell
            
            cell?.setupData(with: itemIdentifier)
            
            return cell
        }
        
        doneDataSource = DataSource(tableView: todoListView.doneTableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoTableViewCell.identifier,
                for: indexPath
            ) as? TodoTableViewCell
            
            cell?.setupData(with: itemIdentifier)
            
            return cell
        }
    }
    
    private func applySnapshot(items: [TodoListModel], datasource: DataSource?) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        datasource?.apply(snapshot)
    }
}

extension TodoListViewController: UITableViewDelegate {
    private func tableViewItem(with tableView: UITableView, _ indexPath: IndexPath) -> TodoListModel? {
        switch tableView {
        case todoListView.todoTableView:
            return todoDataSource?.snapshot().itemIdentifiers[indexPath.row]
        case todoListView.doingTableView:
            return doingDataSource?.snapshot().itemIdentifiers[indexPath.row]
        case todoListView.doneTableView:
            return doneDataSource?.snapshot().itemIdentifiers[indexPath.row]
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = tableViewItem(with: tableView, indexPath) else { return }
        viewModel.cellDidTap(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let item = self?.tableViewItem(with: tableView, indexPath) else { return }
            self?.viewModel.deleteItem(item)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
