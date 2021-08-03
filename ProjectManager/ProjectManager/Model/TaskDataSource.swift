//
//  TaskDataSource.swift
//  ProjectManager
//
//  Created by sookim on 2021/07/27.
//

import UIKit

class TaskDataSource: NSObject, UITableViewDataSource {
    
    var taskType: TaskType
    var tasks: [Task] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("changedTasksValue"), object: self)
        }
    }
    
    init(taskType: TaskType, tasks: [Task]) {
        self.taskType = taskType
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
        
        cell.selectionStyle = .none
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
    
    func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let task = tasks[sourceIndex]
        
        tasks.remove(at: sourceIndex)
        tasks.insert(task, at: destinationIndex)
    }
    
    func addTask(_ newTask: Task, at index: Int) {
        tasks.insert(newTask, at: index)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
}
