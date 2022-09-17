//
//  DoneViewController.swift
//  ProjectManager
//
//  Created by 수꿍, 휴 on 2022/09/17.
//

import UIKit

final class DoneViewController: UIViewController {
    enum Schedule {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Schedule, ProjectUnit>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Schedule, ProjectUnit>

    private var doneViewdataSource: DataSource?
    private var doneViewSnapshot: Snapshot?

    private let viewModel = DoneViewModel(databaseManager: MockLocalDatabaseManager())

    private let doneListView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray6
        tableView.sectionHeaderHeight = 50

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureDataSource()
        configureObserver()
    }

    private func configureUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(doneListView)

        NSLayoutConstraint.activate([
            doneListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            doneListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            doneListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            doneListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func configureDataSource() {
        doneListView.register(cellType: ProjectManagerListCell.self)
        doneListView.delegate = self

        doneViewdataSource = DataSource(
            tableView: doneListView,
            cellProvider: { tableView, indexPath, item in
                let cell: ProjectManagerListCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContents(
                    title: item.title,
                    body: item.body,
                    date: item.deadLine.localizedString
                )
                cell.separatorInset = .zero

                return cell
            }
        )
    }

    private func configureObserver() {
        viewModel.doneData.subscribe { [weak self] projectUnitArray in
            guard let self = self else {
                return
            }

            self.doneViewSnapshot = self.configureSnapshot(data: projectUnitArray)

            guard let doneViewSnapshot = self.doneViewSnapshot else {
                return
            }

            self.doneViewdataSource?.apply(doneViewSnapshot)
        }
    }

    private func configureSnapshot(data: [ProjectUnit]) -> Snapshot {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)

        return snapshot
    }
}

extension DoneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SectionHeaderView()
        headerView.setupLabelText(section: "DONE", number: 0)

        return headerView
    }
}
