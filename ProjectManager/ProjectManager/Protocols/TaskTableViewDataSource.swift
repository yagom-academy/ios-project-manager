//
//  MockJSONDatable.swift
//  ProjectManager
//
//  Created by James on 2021/07/06.
//

import UIKit

protocol TaskTableViewDataSource: UITableViewDataSource {  
    func canHandle(_ session: UIDropSession) -> Bool
    func dragItem(taskType: ProjectTaskType, for indexPath: IndexPath) -> [UIDragItem]
    func moveTask(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, in tableView: UITableView)
}
