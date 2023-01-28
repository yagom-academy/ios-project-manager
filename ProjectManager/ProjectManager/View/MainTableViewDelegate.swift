//
//  MainTableViewDelegate.swift
//  ProjectManager
//
//  Created by Baem on 2023/01/28.
//

import UIKit

class MainTableViewDelegate: NSObject, UITableViewDelegate {
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
    
    private func saveData(of tableView: UITableView, to indexPathRow: Int) -> TodoModel? {
        guard let tableView = tableView as? CustomTableView else { return nil }
        return tableView.data[indexPathRow]
    }
    
    private func countCell(of tableView: UITableView) -> Int {
        guard let tableView = tableView as? CustomTableView else { return .zero }
        return tableView.data.count
    }
    
    private func swipeAction(of tableView: UITableView, to indexPathRow: Int) {
        guard let tableView = tableView as? CustomTableView else { return }
        
        let removeData = tableView.data.remove(at: indexPathRow)
        guard let id = removeData.id else { return }
        CoreDataManager.shared.deleteDate(id: id)
    }
}
