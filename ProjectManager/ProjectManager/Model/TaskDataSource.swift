//
//  TaskDataSource.swift
//  ProjectManager
//
//  Created by sookim on 2021/07/27.
//

import UIKit

class TaskDataSource: NSObject, UITableViewDataSource {
    
    let tasks: [Task]
    
    init(tasks: [Task]) {
        self.tasks = tasks
        super.init()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        else { return UITableViewCell() }
        
        cell.configure(tasks[indexPath.section])
        
        return cell
    }
    
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let taskItem = tasks[indexPath.section]

        let itemProvider = NSItemProvider(object: taskItem)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = taskItem
        return [dragItem]
    }
}
