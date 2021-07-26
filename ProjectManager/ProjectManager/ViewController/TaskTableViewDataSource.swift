//
//  TaskTableViewDataSource.swift
//  ProjectManager
//
//  Created by 오인탁 on 2021/07/23.
//

import UIKit

class TaskTableViewDataSource: NSObject, UITableViewDataSource {
    var onUpdated: () -> Void = {}
    private var tasks: [Task] {
        didSet {
            onUpdated()
        }
    }
    var taskCount: Int {
        return tasks.count
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier) as? ItemTableViewCell else { return UITableViewCell()}
        cell.configure(task: tasks[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension TaskTableViewDataSource {
    func dragItems(for indexPath: IndexPath) -> [UIDragItem] {
        let task: Task = tasks[indexPath.row]
        let itemProvider = NSItemProvider(object: task)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = task
        return [dragItem]
    }
    
    func addTask(_ task: Task, at index: Int) {
        tasks.insert(task, at: index)
    }
    
    func moveTask(at sourceIndex: Int, to destinationIndex: Int) {
        guard sourceIndex != destinationIndex else { return }
        let task = tasks[sourceIndex]
        tasks.remove(at: sourceIndex)
        tasks.insert(task, at: destinationIndex)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func getTask(_ indexPath: IndexPath) -> Task {
        return tasks[indexPath.row]
    }
}
