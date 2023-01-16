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

    private lazy var planListView = PlanListView(frame: view.bounds)

    private lazy var toDoDataSource = configureDataSource(tableView: planListView.toDoTableView)
    private lazy var doingDataSource = configureDataSource(tableView: planListView.doingTableView)
    private lazy var doneDataSource = configureDataSource(tableView: planListView.doneTableView)

    private var planList = DummyProjects.projects
    private var todoList: [Plan] {
        return planList.filter { $0.status == .todo }
    }

    private var doingList: [Plan] {
        return planList.filter { $0.status == .doing }
    }

    private var doneList: [Plan] {
        return planList.filter { $0.status == .done }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureLayout()
        configureToDoSnapshot()
    }

    private func configureLayout() {
        view.addSubview(planListView)

        planListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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


    private func configureDataSource(tableView: UITableView) -> DataSource {
        let dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.reuseIdentifier, for: indexPath)
            self.configureCell(cell, with: todo)

            return cell
        })

        return dataSource
    }

    private func configureToDoSnapshot() {
        var todoSnapshot = Snapshot()
        var doingSnapshot = Snapshot()
        var doneSnapshot = Snapshot()

        todoSnapshot.appendSections([0])
        doingSnapshot.appendSections([0])
        doneSnapshot.appendSections([0])

        todoSnapshot.appendItems(todoList)
        doingSnapshot.appendItems(doingList)
        doneSnapshot.appendItems(doingList)

        toDoDataSource.apply(todoSnapshot)
        doingDataSource.apply(doingSnapshot)
        doneDataSource.apply(doneSnapshot)
    }
}
