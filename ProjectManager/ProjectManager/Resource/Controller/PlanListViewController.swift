//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

final class PlanListViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, Plan>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Plan>

    private var planManager = PlanManager()
    private lazy var planListView = PlanListView(frame: view.bounds)

    private lazy var toDoDataSource = configureDataSource(tableView: planListView.toDoTableView)
    private lazy var doingDataSource = configureDataSource(tableView: planListView.doingTableView)
    private lazy var doneDataSource = configureDataSource(tableView: planListView.doneTableView)

    private var planList = DummyProjects.projects {
        didSet {
            planListView.toDoTableView.reloadData()
        }
    }
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
        configureView()
        configureSnapshot()

    }

    private func configureView() {
        view.addSubview(planListView)

        planListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        planListView.toDoTableView.delegate = self
        planListView.doingTableView.delegate = self
        planListView.doneTableView.delegate = self
    }

    private func configureNavigationBarButton() -> UIBarButtonItem {
        let detailViewController = PlanDetailViewController(navigationTitle: "TODO",
                                                            plan: nil,
                                                            isAdding: true) { [weak self] plan in
            guard let plan = plan else { return }

            self?.planList.append(plan)
            self?.configureSnapshot()
        }

        let buttonAction = UIAction { [weak self] _ in
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

    private func configureSnapshot() {
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

extension PlanListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let plan = pickTableView(tableView, indexPath: indexPath)

        let detailViewController = PlanDetailViewController(navigationTitle: "TODO",
                                                            plan: plan,
                                                                isAdding: false) { [weak self] plan in
            guard let plan = plan else { return }

            //TODO: 업데이트 어케 하누
            guard let index = self?.planManager.fetchIndex(list: self?.planList ?? [], id: plan.id) else { return }

            self?.planList[index].title = plan.title
            self?.planList[index].description = plan.description
            self?.planList[index].deadline = plan.deadline

            self?.configureSnapshot()
        }

        present(detailViewController, animated: true)
    }

    func pickTableView(_ tableView: UITableView, indexPath: IndexPath) -> Plan? {
        switch tableView {
        case planListView.toDoTableView:
            return toDoDataSource.itemIdentifier(for: indexPath)
        case planListView.doingTableView:
            return doingDataSource.itemIdentifier(for: indexPath)
        case planListView.doneTableView:
            return doneDataSource.itemIdentifier(for: indexPath)

        default:
            return nil
        }
    }
}
