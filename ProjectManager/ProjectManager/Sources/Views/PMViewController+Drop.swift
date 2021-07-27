//
//  PMViewController+Drop.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/22.
//

import UIKit

extension PMViewController: UITableViewDropDelegate {

    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Task.self) && session.items.count == 1
    }

    func tableView(_ tableView: UITableView,
                   dropSessionDidUpdate session: UIDropSession,
                   withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        let dropProposal = UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        return dropProposal
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        let dropItem: UITableViewDropItem? = coordinator.items.first

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let row = tableView.numberOfRows(inSection: 0)
            destinationIndexPath = IndexPath(row: row, section: 0)
        }

        dropItem?.dragItem.itemProvider.loadObject(ofClass: Task.self) { [weak self] (data, error) in
            guard let task = data as? Task,
                  let stateTableView = tableView as? StateTableView,
                  let state = stateTableView.state,
                  error == nil else { return }

            self?.viewModel.move(task, to: state, at: destinationIndexPath.row)
        }
    }
}
