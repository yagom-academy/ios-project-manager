//
//  MainTableViewDelegate.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/28.
//

import UIKit

protocol DataSendable {
    func sendData(model: TodoModel)
}

final class MainTableViewDelegate: NSObject, UITableViewDelegate, TableViewMethoding {
    
    var someDelegate: DataSendable?
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dequeuedTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "CustomHeaderView"
        )
        guard let view = dequeuedTableViewHeaderFooterView as? CustomHeaderView,
              let table = tableView as? CustomTableView else {
            return UIView()
        }
        
        view.titleLabel.text = table.title
        view.countLabel.text = countCell(of: tableView).description
        
        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let actions = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { _, _, _ in
            self.swipeAction(of: tableView, to: indexPath.row)
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [actions])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = saveData(of: tableView, to: indexPath.row) else { return }
        someDelegate?.sendData(model: data)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
