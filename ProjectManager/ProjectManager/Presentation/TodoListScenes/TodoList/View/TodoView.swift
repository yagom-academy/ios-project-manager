//
//  TodoView.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/13.
//

import UIKit

import Combine

final class TodoView: UIView {
    typealias DataSource = UITableViewDiffableDataSource<Int, TodoListModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TodoListModel>
    
    private let viewModel: TodoViewModelable
    
    private lazy var headerView = TableHeaderView(title: viewModel.headerTitle())
    private var dataSource: DataSource?
    
    private var cancellables = Set<AnyCancellable>()
        
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    init(viewModel: TodoViewModelable) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews()
        setupConstraint()
        setupView()
        setupTableView()
        makeDataSource()
        bind()
    }
    
    private func bind() {
        viewModel.items
            .sink { [weak self] items in
                self?.applySnapshot(items: items)
                self?.headerView.setupHeaderTodoCountLabel(with: items.count)
            }
            .store(in: &cancellables)
    }
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangeSubviews(headerView, tableView)
    }
    
    private func setupConstraint() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
    }
    
    private func setupTableView() {
        tableView.delegate = self
    }
    
    private func makeDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoTableViewCell.identifier,
                for: indexPath
            ) as? TodoTableViewCell
            
            cell?.setupData(with: itemIdentifier)
            
            return cell
        }
    }
    
    func applySnapshot(items: [TodoListModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}

extension TodoView: UITableViewDelegate {    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
        viewModel.didTapCell(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let item = self?.dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
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
        guard let item = dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return nil }
    
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            return self?.makeUIMenu(tableView, item: item)
        }
    }
    
    private func makeUIMenu(_ tableView: UITableView, item: TodoListModel) -> UIMenu {
        let menuType = viewModel.menuType()
        
        let firstMoveAction = UIAction(title: menuType.firstTitle) { _ in
            self.viewModel.didTapFirstContextMenu(item)
        }

        let secondMoveAction = UIAction(title: menuType.secondTitle) { _ in
            self.viewModel.didTapSecondContextMenu(item)
        }
        
        return UIMenu(title: "", children: [firstMoveAction, secondMoveAction])
    }
}
