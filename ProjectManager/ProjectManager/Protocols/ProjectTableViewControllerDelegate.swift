//
//  ProjectTableViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 로빈 on 2023/01/24.
//

protocol ProjectTableViewControllerDelegate {
    func projectTableViewController(_ projectTableViewController: ProjectTableViewController,
                                    didUpdateProject project: Project)
    func projectTableViewController(_ projectTableViewController: ProjectTableViewController,
                                    didDeleteProject project: Project)
}
