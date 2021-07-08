//
//  NewTodoFormDelegate+Ext.swift
//  ProjectManager
//
//  Created by kio on 2021/07/06.
//

import UIKit

extension ProjectManagerViewController: ProjectManagerDelegate {
    
    func dataPassing(title: String, date: String, description: String) {
        data.append(CellData(title: title, body: description, deadline: date))
    }
}
