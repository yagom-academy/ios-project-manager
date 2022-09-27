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
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configureUI()
        configureDataSource()
        configureSnapshotSection()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func configureDataSource() {
        tableView.register(cellType: HistoryListCell.self)

        dataSource = DataSource(
            tableView: tableView,
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
