//
//  ListView.swift
//  ProjectManager
//
//  Created by 맹선아 on 2023/01/13.
//

import UIKit

class ListView: UIView {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
}
