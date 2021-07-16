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
    func moveTask(from sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, in tableView: UITableView)
    func addTask(task: Task, destinationIndexPath: IndexPath, tableView: UITableView)
    func deleteTask(at indexPath: IndexPath, in tableView: UITableView)
    func appendToDoList(task: Task)
    func fetchToDoList() -> [Task]
    func fetchDoingList() -> [Task]
    func fetchDoneList() -> [Task]
    func modifyList(target: [Task], title: String, deadlineDate: Date, content: String, index: Int)
}
