//
//  ViewController+Delegate.swift
//  ProjectManager
//
//  Created by steven on 7/23/21.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource = dataSources(for: tableView)
        let task = dataSource.task(at: indexPath)
        let taskFormViewController = TaskFormViewController(type: .edit)
        taskFormViewController.delegate = self
        taskFormViewController.configureViews(task)
        let navigationController = UINavigationController(rootViewController: taskFormViewController)
        navigationController.modalPresentationStyle = .formSheet
        self.present(navigationController, animated: true, completion: nil)
    }
}
