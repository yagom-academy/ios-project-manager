//
//  ProjectListViewController+TableView.swift
//  ProjectManager
//
//  Created by 노유빈 on 2023/01/17.
//

import UIKit

extension ProjectListViewController: UITableViewDelegate {
    func fetchProject(tableView: UITableView, indexPath: IndexPath) -> Project {
        if tableView == projectListView.todoTableView {
            return todoList[indexPath.row]
        } else if tableView == projectListView.doingTableView {
            return doingList[indexPath.row]
        } else {
            return doneList[indexPath.row]
        }
    }

    func fetchProjectList(tableView: UITableView) -> [Project] {
        if tableView == projectListView.todoTableView {
            return todoList
        } else if tableView == projectListView.doingTableView {
            return doingList
        } else {
            return doneList
        }
    }

    func createProjectCell(project: Project) {
        projectManager.create(projectList: &projectList, project: project)
        configureSnapshots()
    }

    func updateProjectCell(project: Project) {
        projectManager.update(projectList: &projectList, project: project)
        configureSnapshots()
    }

    func deleteProjectCell(tableView: UITableView, project: Project) {
        guard let dataSource = tableView.dataSource as? DataSource else {
            fatalError()
        }

        projectManager.delete(projectList: &self.projectList, project: project)

        let items = fetchProjectList(tableView: tableView)
        configureSnapshot(dataSource: dataSource, items: items)
    }

    func moveProjectCell(to tableView: UITableView, project: Project, status: Project.Status) {
        var project = project
        project.status = status

        projectManager.delete(projectList: &projectList, project: project)
        projectManager.create(projectList: &projectList, project: project)
        configureSnapshots()
    }
    
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

    //MARK: Cell Swipe Delete Action
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let targetProject = fetchProject(tableView: tableView, indexPath: indexPath)
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, success) in
            self.deleteProjectCell(tableView: tableView, project: targetProject)
            success(true)
        }

        deleteAction.title = "삭제"

        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    // MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProject = fetchProject(tableView: tableView, indexPath: indexPath)
        let projectViewController = ProjectViewController(with: selectedProject, mode: .edit) { project in
            self.updateProjectCell(project: project)
        }

        present(projectViewController, animated: false)
    }
}
