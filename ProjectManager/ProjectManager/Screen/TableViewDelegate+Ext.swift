//
//  TableViewDelegate+Ext.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit
import MobileCoreServices

extension ProjectManagerViewController: UITableViewDelegate {
    
    func checkedTableViewData(currentTableView: UITableView) -> [CellData] {
        
        switch currentTableView {
        case toDoTableView:
            return todoTableViewData
        case doingTableView:
            return doingTableViewData
        default:
            return doneTableViewData
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let data = checkedTableViewData(currentTableView: tableView)
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        return [UIDragItem]
//    }
    
}
