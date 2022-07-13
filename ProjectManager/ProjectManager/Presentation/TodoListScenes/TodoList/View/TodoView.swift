//
//  TodoView.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/13.
//

import UIKit

final class TodoView: UIView {
    typealias DataSource = UITableViewDiffableDataSource<Int, TodoListModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TodoListModel>
    
    private let processType: ProcessType
    private let headerView = TableHeaderView(title: "Todo")
    private var dataSource: DataSource?
        
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
    
    init(processType: ProcessType) {
        self.processType = processType
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
    private struct MenuType {
        let firstTitle: String
        let secondTitle: String
        let firstProcessType: ProcessType
        let secondProcessType: ProcessType
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
//        getViewModel().didTapCell(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let item = self?.dataSource?.snapshot().itemIdentifiers[indexPath.row] else { return }
//            self?.getViewModel().deleteItem(item)
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
        
    private func makeTableViewMenuType(_ tableView: UITableView) -> MenuType? {
        
//        switch tableView {
//        case getTodoListView().todoTableView:
//            return MenuType(
//                firstTitle: "Move to DOING",
//                secondTitle: "Move to DONE",
//                firstProcessType: .doing,
//                secondProcessType: .done
//            )
//        case getTodoListView().doingTableView:
//            return MenuType(
//                firstTitle: "Move to TODO",
//                secondTitle: "Move to DONE",
//                firstProcessType: .todo,
//                secondProcessType: .done
//            )
//        case getTodoListView().doneTableView:
//            return MenuType(
//                firstTitle: "Move to TODO",
//                secondTitle: "Move to DOING",
//                firstProcessType: .todo,
//                secondProcessType: .doing
//            )
//        default:
//            return nil
//        }
        return nil
    }
    
    private func makeUIMenu(_ tableView: UITableView, item: TodoListModel) -> UIMenu {
        guard let menuType = makeTableViewMenuType(tableView) else { return UIMenu() }
        
//        let firstMoveAction = UIAction(title: menuType.firstTitle) { _ in
//            self.getViewModel().didLongPressCell(item, to: menuType.firstProcessType)
//        }
//
//        let secondMoveAction = UIAction(title: menuType.secondTitle) { _ in
//            self.getViewModel().didLongPressCell(item, to: menuType.secondProcessType)
//        }
        
        return UIMenu(title: "", children: [])
    }
}
