//
//  PMViewController+Drag.swift
//  ProjectManager
//
//  Created by Ryan-Son on 2021/07/22.
//

import UIKit

extension PMViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        switch tableView {
        case todoStackView.stateTableView:
            return dragItem(with: .todo, at: indexPath.row)
        case doingStackView.stateTableView:
            return dragItem(with: .doing, at: indexPath.row)
        case doneStackView.stateTableView:
            return dragItem(with: .done, at: indexPath.row)
        default:
            return []
        }
    }

    private func dragItem(with state: Task.State, at index: Int) -> [UIDragItem] {
        var draggedTask: Task?

        switch state {
        case .todo:
            draggedTask = viewModel.task(from: .todo, at: index)
        case .doing:
            draggedTask = viewModel.task(from: .doing, at: index)
        case .done:
            draggedTask = viewModel.task(from: .done, at: index)
        }
        guard let draggedTask = draggedTask else { return [] }
        let itemProvider = NSItemProvider(object: draggedTask)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
