//
//  ProjectTableViewController.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/21.
//

import UIKit

final class ProjectTableViewController: UITableViewController {
    typealias DataSource = UITableViewDiffableDataSource<Int, Project>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Project>

    // MARK: Properties
    let status: ProjectStatus
    private var projectList: [Project] = [] {
        didSet {
            configureSnapshot(items: self.projectList)
            print("\(status.name) 업데이트")
        }
    }

    private let delegate: ProjectTableViewControllerDelegate
    private lazy var dataSource = makeDataSource()

    // MARK: View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        configureLongPressGesture()
    }

    // MARK: Initialization
    init(status: ProjectStatus, tableView: UITableView, delegate: ProjectTableViewControllerDelegate) {
        self.status = status
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        
        self.tableView = tableView
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Data Source
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, project in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseIdentifier) as? ProjectTableViewCell else {
                return UITableViewCell()
            }

            cell.configure(with: project)

            return cell
        }

        return dataSource
    }

    private func configureSnapshot(items: [Project]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)

        if #available(iOS 15.0, *) {
            dataSource.applySnapshotUsingReloadData(snapshot)
        } else {
            dataSource.apply(snapshot, animatingDifferences: false)
        }
    }

    // MARK: Long Press Gesture
    private func configureLongPressGesture() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))

        tableView.addGestureRecognizer(longPressGestureRecognizer)
    }

    @objc private func longPress(sender: UILongPressGestureRecognizer) {
        if sender.view != tableView {
            return
        }

        let location = sender.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: location) else {
            return
        }

        switch sender.state {
        case .began:
            presentPopoverMenu(tableView: tableView, indexPath: indexPath)
        default:
            break
        }
    }

    // MARK: Popover
    private func move(project: Project, to status: ProjectStatus) {
        var statusChangedProject = project
        statusChangedProject.status = status

        delegate.projectTableViewController(self, didDeleteProject: project)
        delegate.projectTableViewController(self, didUpdateProject: statusChangedProject)
    }

    private func makeAlertController(with project: Project) -> UIAlertController {
        let MoveTodoAction = UIAlertAction(title: "Move To TODO", style: .default) { [weak self] _ in
            self?.move(project: project, to: .todo)
        }

        let MoveDoingAction = UIAlertAction(title: "Move To DOING", style: .default) { [weak self] _ in
            self?.move(project: project, to: .doing)
        }

        let MoveDoneAction = UIAlertAction(title: "Move To DONE", style: .default) { [weak self] _ in
            self?.move(project: project, to: .done)
        }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        switch status {
        case .todo:
            alert.addAction(MoveDoingAction)
            alert.addAction(MoveDoneAction)
        case .doing:
            alert.addAction(MoveTodoAction)
            alert.addAction(MoveDoneAction)
        case .done:
            alert.addAction(MoveTodoAction)
            alert.addAction(MoveDoingAction)
        }

        return alert
    }

    private func presentPopoverMenu(tableView: UITableView, indexPath: IndexPath) {
        let selectedProject = projectList[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }

        let alert = makeAlertController(with: selectedProject)
        let popover = alert.popoverPresentationController
        popover?.sourceView = cell

        present(alert, animated: true)
    }

    func update(with projectList: [Project]) {
        self.projectList = projectList
    }
}

// MARK: Tableview Delegate
extension ProjectTableViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProjectTableViewHeaderView.reuseIdentifier)
                as? ProjectTableViewHeaderView else {
            return UIView()
        }

        let projectCount = tableView.numberOfRows(inSection: section)
        headerView.configure(title: status.name, count: projectCount)

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let targetProject = projectList[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, success) in
            self.delegate.projectTableViewController(self, didDeleteProject: targetProject)
            success(true)
        }

        deleteAction.title = "삭제"

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let targetProject = projectList[indexPath.row]
        let projectViewController = ProjectViewController(with: targetProject,
                                                          mode: .edit,
                                                          delegate: self)

        present(UINavigationController(rootViewController: projectViewController), animated: false)
    }
}

// MARK: ProjectViewControllerDelegate
extension ProjectTableViewController: ProjectViewControllerDelegate {
    func projectViewController(_ projectViewController: ProjectViewController, didUpdateProject project :Project) {
        delegate.projectTableViewController(self, didUpdateProject: project)
    }
}
