//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by 로빈솜 on 2023/01/11.
//

import UIKit

final class PlanListViewController: UIViewController, UITableViewDelegate {
    typealias DataSource = UITableViewDiffableDataSource<Int, Plan>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Plan>

    private let planListView = PlanListView()
    private lazy var toDoDataSource = configureDataSource()
    private lazy var doingDataSource = configureDataSource()
    private lazy var doneDataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureLayout()
        configureToDoSnapshot()
    }

    private func configureLayout() {
        view.addSubview(planListView)

        planListView.toDoTableView.dataSource = toDoDataSource
        planListView.doingTableView.dataSource = doingDataSource
        planListView.doneTableView.dataSource = doneDataSource
    }

    private func configureNavigationBarButton() -> UIBarButtonItem {
        let buttonAction = UIAction { [weak self] _ in
            let detailViewController = PlanDetailViewController()
            self?.present(detailViewController, animated: true)
        }

        let button = UIBarButtonItem(systemItem: .add, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationBar() {
        navigationItem.title = "Project Manager"
        navigationItem.rightBarButtonItem = configureNavigationBarButton()
    }

    private func configureCell(_ cell: UITableViewCell, with todo: Plan) {
        guard let cell = cell as? PlanTableViewCell else {
            return
        }

        cell.configureCell(with: todo)
    }


    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(tableView: planListView.toDoTableView, cellProvider: { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.reuseIdentifier, for: indexPath)
            self.configureCell(cell, with: todo)
            return cell
        })

        return dataSource
    }

    private func configureToDoSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
//        snapshot.appendItems([ToDo(), ToDo(), ToDo()])

        toDoDataSource.apply(snapshot)
        doingDataSource.apply(snapshot)
        doneDataSource.apply(snapshot)
    }
}
