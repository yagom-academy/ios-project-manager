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
    private let alertManager = AlertManager()

    private lazy var toDoDataSource = configureDataSource(tableView: planListView.toDoTableView)
    private lazy var doingDataSource = configureDataSource(tableView: planListView.doingTableView)
    private lazy var doneDataSource = configureDataSource(tableView: planListView.doneTableView)

    private var planList = MockData.projects
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
        configureLongPressGestureRecognizer()
    }

    private func configureView() {
        view.addSubview(planListView)

        planListView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        planListView.toDoTableView.delegate = self
        planListView.doingTableView.delegate = self
        planListView.doneTableView.delegate = self
    }

    private func configureNavigationBarButton() -> UIBarButtonItem {
        let detailViewController = PlanDetailViewController(navigationTitle: Content.toDo,
                                                            plan: nil,
                                                            isAdding: true) { plan in
            guard let plan = plan else {
                let errorAlert = self.alertManager.showErrorAlert(title: Content.savingError)
                self.present(errorAlert, animated: true)

                return
            }

            self.planManager.insert(planList: &self.planList, plan: plan)
            self.configureSnapshot()
        }

        let buttonAction = UIAction { [weak self] _ in
            self?.present(detailViewController, animated: true)
        }

        let button = UIBarButtonItem(systemItem: .add, primaryAction: buttonAction)

        return button
    }

    private func configureNavigationBar() {
        navigationItem.title = Content.navigationTitle
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
        doneSnapshot.appendItems(doneList)

        toDoDataSource.apply(todoSnapshot)
        doingDataSource.apply(doingSnapshot)
        doneDataSource.apply(doneSnapshot)
    }

    private func configureLongPressGestureRecognizer() {
        let tableViews = [planListView.toDoTableView, planListView.doingTableView, planListView.doneTableView]

        tableViews.forEach { tableView in
            let gestureRecognizer = UILongPressGestureRecognizer(target: self,
                                                                 action: #selector(tappedLongPress))
            gestureRecognizer.minimumPressDuration = 0.5
            gestureRecognizer.delegate = self
            gestureRecognizer.delaysTouchesBegan = true
            tableView.addGestureRecognizer(gestureRecognizer)
        }
    }

    private enum Content {
        static let toDo = "🗒 TODO"
        static let doing = "🏃‍♀️ DOING"
        static let done = "🙆‍♀️ DONE"
        static let delete = "Delete"
        static let navigationTitle = "Project Manager"
        static let savingError = "할일을 저장하지 못 헀습니다."
        static let unknownError = "알 수 없는 오류"
        static let loadingError = "할일을 불러오지 못 헀습니다."
        static let actionSheetText = "Move to "
    }
}

extension PlanListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let plan = didSelected(in: tableView, to: indexPath)

        let detailViewController = PlanDetailViewController(navigationTitle: String(describing: plan?.status),
                                                            plan: plan,
                                                            isAdding: false) { plan in
            guard let plan = plan else {
                let errorAlert = self.alertManager.showErrorAlert(title: Content.savingError)
                self.present(errorAlert, animated: true)
                return
            }

            self.planManager.update(planList: &self.planList, plan: plan)
            self.configureSnapshot()
        }

        present(detailViewController, animated: true)
    }

    func didSelected(in tableView: UITableView, to indexPath: IndexPath) -> Plan? {
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let plan = didSelected(in: tableView, to: indexPath)

        let deleteAction = UIContextualAction(style: .destructive, title: Content.delete) { _, _, _  in
            let handler: (UIAlertAction) -> Void = { _ in
                self.planManager.delete(planList: &self.planList, id: plan?.id)
                self.configureSnapshot()
            }

            let alert = self.alertManager.showDeleteAlert(handler: handler)
            self.present(alert, animated: true)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlanListHeaderView.reuseIdentifier)
                as? PlanListHeaderView else { return UIView() }

        switch tableView {
        case planListView.toDoTableView:
            headerView.configure(title: Content.toDo, count: todoList.count)
        case planListView.doingTableView:
            headerView.configure(title: Content.doing, count: doingList.count)
        case planListView.doneTableView:
            headerView.configure(title: Content.done, count: doneList.count)
        default:
            let errorAlert = alertManager.showErrorAlert(title: Content.unknownError)
            present(errorAlert, animated: true)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
            let errorAlert = alertManager.showErrorAlert(title: Content.unknownError)
            present(errorAlert, animated: true)
        }
    }

    private func presentPopoverMenu(tableView: UITableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            let errorAlert = self.alertManager.showErrorAlert(title: Content.loadingError)
            self.present(errorAlert, animated: true)

            return
        }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        guard let plan = didSelected(in: tableView, to: indexPath) else { return }

        moveState(to: plan).forEach { alert.addAction($0) }

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
            self.planManager.update(list: &self.planList, id: plan.id, status: status)
            self.configureSnapshot()
        }

        return action
    }
}
