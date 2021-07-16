//
//  NewTodoFormDelegata.swift
//  ProjectManager
//
//  Created by kio on 2021/07/06.
//

import UIKit

protocol NewTodoFormViewControllerDelegate {
    func passModalViewData(title: String, date: Double, description: String)
    
    func updateData(tableView: UITableView, title: String, date: Double, indexPath: Int, description: String)
}
