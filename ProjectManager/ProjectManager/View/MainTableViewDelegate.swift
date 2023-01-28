//
//  MainTableViewDelegate.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/28.
//

import UIKit

final class MainTableViewDelegate: NSObject, UITableViewDelegate, TableViewMethoding {
    
    var controller: UIViewController?
    
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
        let data = saveData(of: tableView, to: indexPath.row)
        let modalController = UINavigationController(rootViewController: ModalViewContoller(model: data))
        
        modalController.modalPresentationStyle = .formSheet
        controller?.present(modalController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
