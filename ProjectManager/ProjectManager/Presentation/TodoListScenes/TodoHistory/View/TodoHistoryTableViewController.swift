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
    
    weak var coordinator: TodoHistoryViewCoordinator?
    private let viewModel: TodoHistoryTableViewModelable
    
    private var cancelBag = Set<AnyCancellable>()
    private var dataSource: DataSource?
    
    init(_ viewModel: TodoHistoryTableViewModelable) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeDataSource()
        registerTableViewCell()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.dismiss()
    }
    
    private func bind() {
        viewModel.items
            .sink { [weak self] items in
                self?.applySnapshot(items)
            }
            .store(in: &cancelBag)
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
