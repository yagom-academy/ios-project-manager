//
//  TodoListTableViewDelegate.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/11.
//

import UIKit

extension TodoListViewController: UITableViewDelegate {
    private struct MenuType {
        let firstTitle: String
        let secondTitle: String
        let firstProcessType: ProcessType
        let secondProcessType: ProcessType
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = makeTableViewItem(with: tableView, indexPath) else { return }
        getViewModel().didTapCell(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            guard let item = self?.makeTableViewItem(with: tableView, indexPath) else { return }
            self?.getViewModel().deleteItem(item)
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let item = makeTableViewItem(with: tableView, indexPath) else { return nil }
    
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
            return self?.makeUIMenu(tableView, item: item)
        }
    }
    
    private func makeTableViewItem(with tableView: UITableView, _ indexPath: IndexPath) -> TodoListModel? {
        switch tableView {
        case getTodoListView().todoTableView:
            return getTodoDataSource()?.snapshot().itemIdentifiers[indexPath.row]
        case getTodoListView().doingTableView:
            return getDoingDataSource()?.snapshot().itemIdentifiers[indexPath.row]
        case getTodoListView().doneTableView:
            return getDoneDataSource()?.snapshot().itemIdentifiers[indexPath.row]
        default:
            return nil
        }
    }
        
    private func makeTableViewMenuType(_ tableView: UITableView) -> MenuType? {
        switch tableView {
        case getTodoListView().todoTableView:
            return MenuType(
                firstTitle: "Move to DOING",
                secondTitle: "Move to DONE",
                firstProcessType: .doing,
                secondProcessType: .done
            )
        case getTodoListView().doingTableView:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DONE",
                firstProcessType: .todo,
                secondProcessType: .done
            )
        case getTodoListView().doneTableView:
            return MenuType(
                firstTitle: "Move to TODO",
                secondTitle: "Move to DOING",
                firstProcessType: .todo,
                secondProcessType: .doing
            )
        default:
            return nil
        }
    }
    
    private func makeUIMenu(_ tableView: UITableView, item: TodoListModel) -> UIMenu {
        guard let menuType = makeTableViewMenuType(tableView) else { return UIMenu() }
        
        let firstMoveAction = UIAction(title: menuType.firstTitle) { _ in
            self.getViewModel().didLongPressCell(item, to: menuType.firstProcessType)
        }
        
        let secondMoveAction = UIAction(title: menuType.secondTitle) { _ in
            self.getViewModel().didLongPressCell(item, to: menuType.secondProcessType)
        }
        
        return UIMenu(title: "", children: [firstMoveAction, secondMoveAction])
    }
}
