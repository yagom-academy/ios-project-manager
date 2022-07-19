//
//  TodoHistoryTableViewController.swift
//  ProjectManager
//
//  Created by 김도연 on 2022/07/19.
//

import UIKit
import Combine

final class TodoHistoryTableViewController: UITableViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Int, TodoHistory>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TodoHistory>
    
    private var dataSource: DataSource?
    private var cancelBag = Set<AnyCancellable>()
    
    private let viewModel: TodoHistoryTableViewModelable
    
    init(_ viewModel: TodoHistoryTableViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataSource()
        registerTableViewCell()
    }
    
    private func registerTableViewCell() {
        tableView.register(TodoHistoryTableViewCell.self, forCellReuseIdentifier: TodoHistoryTableViewCell.identifier)
    }
    
    private func makeDataSource() {
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoHistoryTableViewCell.identifier,
                for: indexPath
            ) as? TodoHistoryTableViewCell
            cell?.setupData(with: item)
            return cell
        }
    }
    
    private func applySnapshot(_ items: [TodoHistory]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.zero])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot)
    }
}
