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
            self?.todoListView.setupHeaderTodoCountLabel(with: items.count)
        }
        .store(in: &cancellables)
        
        viewModel.doingItems.sink { [weak self] items in
            self?.applySnapshot(items: items, datasource: self?.doingDataSource)
            self?.todoListView.setupHeaderDoingCountLabel(with: items.count)
        }
        .store(in: &cancellables)
        
        viewModel.doneItems.sink { [weak self] items in
            self?.applySnapshot(items: items, datasource: self?.doneDataSource)
            self?.todoListView.setupHeaderDoneCountLabel(with: items.count)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = makeTableViewItem(with: tableView, indexPath) else { return }
        viewModel.cellDidTap(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let item = self?.makeTableViewItem(with: tableView, indexPath) else { return }
            self?.viewModel.deleteItem(item)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let item = makeTableViewItem(with: tableView, indexPath) else { return nil }
    
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            return self?.makeUIMenu(tableView, item: item)
        }
    }
    
    private func makeTableViewItem(with tableView: UITableView, _ indexPath: IndexPath) -> TodoListModel? {
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
        
    private func makeTableViewMenuType(_ tableView: UITableView) -> MenuType? {
        switch tableView {
        case todoListView.todoTableView:
            return MenuType(
                firstTitle: "Move to DOING",
                secondTitle: "Move to DONE",
                firstProcessType: .doing,
                secondProcessType: .done
            )
        case todoListView.doingTableView:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DONE",
                firstProcessType: .todo,
                secondProcessType: .done
            )
        case todoListView.doneTableView:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DOING",
                firstProcessType: .todo,
                secondProcessType: .doing
            )
        default:
            return nil
        }
    }
    
    private func makeUIMenu(_ tableView: UITableView, item: TodoListModel) -> UIMenu {
        guard let menuType = makeTableViewMenuType(tableView) else { return UIMenu() }
        
        let firstMoveAction = UIAction(title: menuType.firstTitle) { _ in
            self.viewModel.cellDidLongPress(item, to: menuType.firstProcessType)
        }
        
        let secondMoveAction = UIAction(title: menuType.secondTitle) { _ in
            self.viewModel.cellDidLongPress(item, to: menuType.secondProcessType)
        }
        
        return UIMenu(title: "", children: [firstMoveAction, secondMoveAction])
    }
}

private struct MenuType {
    let firstTitle: String
    let secondTitle: String
    let firstProcessType: ProcessType
    let secondProcessType: ProcessType
}
