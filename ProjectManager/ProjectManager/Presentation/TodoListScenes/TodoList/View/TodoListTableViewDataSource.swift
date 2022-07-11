//
//  TodoListTableViewDataSource.swift
//  ProjectManager
//
//  Created by 조민호 on 2022/07/11.
//

import UIKit

final class TodoListTableViewDataSource: UITableViewDiffableDataSource<Int, TodoListModel> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, TodoListModel>
    
    init(_ tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TodoTableViewCell.identifier,
                for: indexPath
            ) as? TodoTableViewCell
            
            cell?.setupData(with: itemIdentifier)
            
            return cell
        }
    }
    
    func applySnapshot(items: [TodoListModel], datasource: TodoListTableViewDataSource?) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        datasource?.apply(snapshot)
    }
}
