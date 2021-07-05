//
//  TableViewDelegate+Ext.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit

extension ProjectManagerViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }
}
