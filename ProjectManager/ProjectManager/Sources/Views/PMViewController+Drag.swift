//
//  PMViewController+Drag.swift
//  ProjectManager
//
//  Created by duckbok, Ryan-Son on 2021/07/22.
//

import UIKit

extension PMViewController: UITableViewDragDelegate {

    func tableView(_ tableView: UITableView,
                   itemsForBeginning session: UIDragSession,
                   at indexPath: IndexPath) -> [UIDragItem] {
        guard let stateTableView = tableView as? StateTableView,
              let state = stateTableView.state else { return [] }

        return dragItem(with: state, at: indexPath.row)
    }

    private func dragItem(with state: Task.State, at index: Int) -> [UIDragItem] {
        guard let draggedTask = viewModel.task(from: state, at: index) else { return [] }
        let itemProvider = NSItemProvider(object: draggedTask)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}
