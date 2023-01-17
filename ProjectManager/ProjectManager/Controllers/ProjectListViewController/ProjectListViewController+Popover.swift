//
//  ProjectListViewController+Popover.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/18.
//

import UIKit

extension ProjectListViewController {
    private func makeAlertController(tableView: ProjectTableView, indexPath: IndexPath) -> UIAlertController {
        let project = self.fetchProject(tableView: tableView, indexPath: indexPath)
        let MoveTodoAction = UIAlertAction(title: "Move To TODO", style: .default) { _ in
            self.moveProjectCell(to: self.projectListView.todoTableView, project: project, status: .todo)
        }

        let MoveDoingAction = UIAlertAction(title: "Move To DOING", style: .default) { _ in
            self.moveProjectCell(to: self.projectListView.doingTableView, project: project, status: .doing)
        }

        let MoveDoneAction = UIAlertAction(title: "Move To DONE", style: .default) { _ in
            self.moveProjectCell(to: self.projectListView.doneTableView, project: project, status: .done)
        }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if tableView == projectListView.todoTableView {
            alert.addAction(MoveDoingAction)
            alert.addAction(MoveDoneAction)
        } else if tableView == projectListView.doingTableView {
            alert.addAction(MoveTodoAction)
            alert.addAction(MoveDoneAction)
        } else {
            alert.addAction(MoveTodoAction)
            alert.addAction(MoveDoingAction)
        }

        return alert
    }

    private func presentPopoverMenu(tableView: ProjectTableView, indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            fatalError()
        }

        let alert = makeAlertController(tableView: tableView, indexPath: indexPath)
        let popover = alert.popoverPresentationController
        popover?.sourceView = cell
        popover?.sourceRect = cell.bounds

        present(alert, animated: true)
    }

    @objc private func longPress(sender: UILongPressGestureRecognizer) {
        guard let tableView = sender.view as? ProjectTableView else {
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

    func configureLongPressGesture() {
        let todoTableViewRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        let doingTableViewRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        let doneTableViewRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))

        projectListView.todoTableView.addGestureRecognizer(todoTableViewRecognizer)
        projectListView.doingTableView.addGestureRecognizer(doingTableViewRecognizer)
        projectListView.doneTableView.addGestureRecognizer(doneTableViewRecognizer)
    }
}
