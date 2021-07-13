//
//  NewTodoFromViewControllerDelegate.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/13.
//

import UIKit

extension NewTodoFormViewController: NewTodoFormDelegate {
    func getIndexPath(_ tableView: UITableView, row: Int, data: CellData) {
        self.sentIndexPath = row
        self.tableView = tableView
    }
}
