//
//  NewTodoFromDelegate.swift
//  ProjectManager
//
//  Created by 김민성 on 2021/07/13.
//

import UIKit

protocol NewTodoFormDelegate: AnyObject {
    func getIndexPath(_ tableView: UITableView, row: Int, data: CellData)
}
