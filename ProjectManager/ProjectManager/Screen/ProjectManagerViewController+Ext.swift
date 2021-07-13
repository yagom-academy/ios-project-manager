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
    
    
}
