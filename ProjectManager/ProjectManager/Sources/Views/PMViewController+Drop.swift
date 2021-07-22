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

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            print("여긴 어디지")
            destinationIndexPath = IndexPath.init(row: 0, section: 0)
        }

        coordinator.items.first?.dragItem.itemProvider.loadObject(ofClass: Task.self) { [weak self] (data, error) in
            guard let task = data as? Task,
                  error == nil,
                  let self = self else { return }

            switch tableView {
            case self.todoStackView.stateTableView:
                self.viewModel.move(task, to: .todo, at: destinationIndexPath.row)
            case self.doingStackView.stateTableView:
                self.viewModel.move(task, to: .doing, at: destinationIndexPath.row)
            case self.doneStackView.stateTableView:
                self.viewModel.move(task, to: .done, at: destinationIndexPath.row)
            default:
                return
            }
        }
    }
}
