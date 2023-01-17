//
//  ProjectListViewController+Delegate.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import UIKit

extension ProjectListViewController: UITableViewDelegate {
    // MARK: TableViewHeader
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProjectTableViewHeaderView.reuseIdentifier)
                as? ProjectTableViewHeaderView else {
            return UIView()
        }

        guard let tableView = tableView as? ProjectTableView else {
            fatalError()
        }

        let projectCount = tableView.numberOfRows(inSection: section)
        headerView.configure(title: tableView.headerTitle, count: projectCount)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    //MARK: Cell SwipeAction
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let targetProject = fetchProject(tableView: tableView, indexPath: indexPath)
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, success) in
            self.deleteProjectCell(tableView: tableView, project: targetProject)
            tableView.reloadData()
            success(true)
        }

        deleteAction.title = "삭제"

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
