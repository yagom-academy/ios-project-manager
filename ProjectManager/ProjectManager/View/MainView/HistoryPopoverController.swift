//
//  HistoryPopoverController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/27.
//

import UIKit

final class HistoryPopoverController: UIViewController {
    enum Schedule {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Schedule, HistoryLog>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, HistoryLog>

    var dataSource: DataSource?
    var snapshot: Snapshot?
    
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
        configureSnapshotSection()
    }
    
    private func configureUI() {
        self.view.addSubview(historyTableView)
        
        NSLayoutConstraint.activate([
            historyTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            historyTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            historyTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            historyTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func configureDataSource() {
        historyTableView.register(cellType: HistoryListCell.self)

        dataSource = DataSource(
            tableView: historyTableView,
            cellProvider: { tableView, indexPath, item in
                let cell: HistoryListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContent(
                    description: item.content,
                    date: item.time.localizedString
                )

                cell.separatorInset = .zero

                return cell
            }
        )
    }

    private func configureSnapshotSection() {
        snapshot = Snapshot()
        snapshot?.appendSections([.main])
    }

    func configureSnapshotItem(data: HistoryLog) {
        snapshot?.appendItems([data])
    }
}
