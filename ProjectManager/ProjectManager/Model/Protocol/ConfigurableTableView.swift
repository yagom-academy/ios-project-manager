//
//  ConfigurableTableView.swift
//  ProjectManager
//
//  Created by Hemg on 2023/09/29.
//

import UIKit

protocol ConfigurableTableView {
    func configureTableView(_ tableView: UITableView)
}

extension ConfigurableTableView {
    func configureTableView(_ tableView: UITableView) {
        tableView.dataSource = self as? UITableViewDataSource
        tableView.delegate = self as? UITableViewDelegate
        tableView.register(ListTitleCell.self, forCellReuseIdentifier: ReuseIdentifier.listTitleCell)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: ReuseIdentifier.descriptionCell)
    }
}
