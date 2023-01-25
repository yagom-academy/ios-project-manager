//
//  ToDoListViewController.swift
//  ProjectManager
//
//  Created by som on 2023/01/11.
//

import UIKit

final class PlanListViewController: UITableViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, Plan>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Plan>

    private enum LayoutConstraint {
        static let headerViewHeight: CGFloat = 50
    }
    private var status: Plan.Status
    private var planManager = PlanManager()
    private var planListDelegate: PlanListDelegate?
    private var alertDelegate: AlertDelegate?
    private lazy var planListView = PlanListView(frame: view.bounds)
    private lazy var dataSource = configureDataSource()
    private var planList: [Plan] = [] {
        didSet {
            tableView.reloadData()
            configureSnapshot(items: planList)
        }
    }

    init(status: Plan.Status, delegate: PlanListDelegate, tableView: UITableView) {
        self.status = status
        self.planListDelegate = delegate

        super.init(nibName: nil, bundle: nil)
        self.tableView = tableView
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        fetch()
        configureView()
        configureLongPressGestureRecognizer()
    }

    private func configureView() {
        view.addSubview(planListView)

        planListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        planListView.setTableViewDelegate(self)
    }

    private func configureCell(_ cell: UITableViewCell, with todo: Plan) {
        guard let cell = cell as? PlanTableViewCell else {
            return
        }

        cell.configureCell(with: todo)
    }


    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, todo in
            let cell = tableView.dequeueReusableCell(withIdentifier: PlanTableViewCell.reuseIdentifier, for: indexPath)
            self.configureCell(cell, with: todo)
            return cell
        }

        return dataSource
    }

    private func configureSnapshot(items: [Plan]) {
        var snapshot = Snapshot()

        snapshot.appendSections([Content.zero])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }

    private func configureLongPressGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                             action: #selector(tappedLongPress))
        gestureRecognizer.minimumPressDuration = Content.minimumPressDuration
        gestureRecognizer.delegate = self
        gestureRecognizer.delaysTouchesBegan = true
        tableView.addGestureRecognizer(gestureRecognizer)
    }
}

extension PlanListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailViewController = PlanDetailViewController(navigationTitle: status.name,
                                                            plan: planList[indexPath.row],
                                                            isAdding: false)

        present(detailViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: Content.delete) { _, _, _  in
            let handler: (UIAlertAction) -> Void = { _ in
                self.delete(plan: self.planList[indexPath.row])
            }

            self.alertDelegate?.showDeleteAlert(handler: handler)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlanListHeaderView.reuseIdentifier)
                as? PlanListHeaderView else { return UIView() }

        headerView.configure(title: status.name, count: planList.count)

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return LayoutConstraint.headerViewHeight
    }
}

extension PlanListViewController: UIGestureRecognizerDelegate {
    @objc func tappedLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        guard let tableView = gestureRecognizer.view as? UITableView else { return }

        let location = gestureRecognizer.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else { return }

        switch gestureRecognizer.state {
        case .began:
            presentPopoverMenu(tableView: tableView, indexPath: indexPath)
        default:
            alertDelegate?.showErrorAlert(title: Content.unknownError)
        }
    }

    private func presentPopoverMenu(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            alertDelegate?.showErrorAlert(title: Content.loadingError)

            return
        }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        moveState(to: planList[indexPath.row]).forEach { alert.addAction($0) }

        let popover = alert.popoverPresentationController
        popover?.sourceView = cell
        popover?.sourceRect = cell.bounds

        present(alert, animated: true)
    }

    private func moveState(to plan: Plan) -> [UIAlertAction] {
        var actions: [UIAlertAction] = []
        switch plan.status {
        case .todo:
            actions.append(configureAlertAction(to: plan, by: .doing))
            actions.append(configureAlertAction(to: plan, by: .done))
        case .doing:
            actions.append(configureAlertAction(to: plan, by: .todo))
            actions.append(configureAlertAction(to: plan, by: .done))
        case .done:
            actions.append(configureAlertAction(to: plan, by: .todo))
            actions.append(configureAlertAction(to: plan, by: .doing))
        }
        return actions
    }

    private func configureAlertAction(to plan: Plan, by status: Plan.Status) -> UIAlertAction {
        let actionTitle = Content.actionSheetText + String(describing: status)
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            // TODO: 리펙 필요
            var changedPlan = plan
            changedPlan.status = status

            self.updateStatus(plan: plan, status: status)
            self.fetch()
            self.planListDelegate?.sendToUpdate(plan: changedPlan)
        }

        return action
    }
}

extension PlanListViewController: PlanDelegate {
    func add(plan: Plan) {
        planManager.insert(plan: plan)
    }

    func fetch() {
        planList = planManager.fetchAll(status: status)
    }

    func update(plan: Plan) {
        planManager.update(plan: plan)
    }

    func updateStatus(plan: Plan, status: Plan.Status) {
        planManager.update(id: plan.id, status: status)
        fetch()
    }

    func delete(plan: Plan) {
        planManager.delete(id: plan.id)
    }
}
