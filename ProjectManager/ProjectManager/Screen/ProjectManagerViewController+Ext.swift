//
//  NewTodoFormDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/06.
//

import UIKit

extension ProjectManagerViewController: ProjectManagerDelegate {
    func dataPassing(title: String, date: Double, description: String) {
        todoTableViewData.append(CellData(title: title, body: description, deadline: date, superViewType: TableViewType.todoTableView))
    }
    
    func updateData(tableView: UITableView, title: String, date: Double, indexPath: Int, description: String) {
        switch tableView {
        case todoTableView:
            todoTableViewData[indexPath].title = title
            todoTableViewData[indexPath].body = description
            todoTableViewData[indexPath].deadline = date
        case doingTableView:
            doingTableViewData[indexPath].title = title
            doingTableViewData[indexPath].body = description
            doingTableViewData[indexPath].deadline = date
        default:
            doneTableViewData[indexPath].title = title
            doneTableViewData[indexPath].body = description
            doneTableViewData[indexPath].deadline = date
        }
    }
}
