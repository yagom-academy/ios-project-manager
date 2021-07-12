//
//  TableViewDelegate+Ext.swift
//  ProjectManager
//
//  Created by TORI on 2021/07/02.
//

import UIKit
import MobileCoreServices

extension ProjectManagerViewController: UITableViewDelegate {
    
    func distinguishedTableViewData(currentTableView: UITableView) -> [CellData] {
        
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
        
        return 1
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
