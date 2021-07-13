//
//  MockJSONData.swift
//  ProjectManager
//
//  Created by Jay, Ian, James on 2021/07/05.
//

import UIKit

// MARK: - enum ProjectTaskType

enum ProjectTaskType: String {
    case todo, doing, done
    
    var description: String {
        switch self {
        case .todo:
            return "todo"
        case .doing:
            return "doing"
        case .done:
            return "done"
        }
    }
    
    var model: [Task] {
        switch self {
        case .todo:
            return self.taskArrayFromAsset()
        case .doing:
            return self.taskArrayFromAsset()
        case .done:
            return self.taskArrayFromAsset()
        }
    }
    
    private func taskArrayFromAsset() -> [Task] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        guard let dataAsset = NSDataAsset.init(name: self.description),
              let model = try? decoder.decode([Task].self, from: dataAsset.data) else { return [] }
        return model
    }
}

// MARK: - ParsingModel

final class TaskDataSource: NSObject, TaskTableViewDataSource {
    
    private weak var toDoTableView: UITableView!
    private weak var doingTableView: UITableView!
    private weak var doneTableView: UITableView!

    private var toDoList: [Task]
    private var doingList: [Task]
    private var doneList: [Task]
    
    init(toDoTableView: UITableView, doingTableView: UITableView, doneTableView: UITableView) {
        self.toDoList = ProjectTaskType.todo.model
        self.doingList = ProjectTaskType.doing.model
        self.doneList = ProjectTaskType.done.model
        
        self.toDoTableView = toDoTableView
        self.doingTableView = doingTableView
        self.doneTableView = doneTableView
    }
    
    func canHandle(_ session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: Task.self)
    }
    
    func dragItem(taskType: ProjectTaskType, for indexPath: IndexPath) -> [UIDragItem] {
        switch taskType {
        case .todo:
            return createDragItem(tasks: toDoList, for: indexPath)
        case .doing:
            return createDragItem(tasks: doingList, for: indexPath)
        case .done:
            return createDragItem(tasks: doneList, for: indexPath)
        }
    }
    
    private func createDragItem(tasks: [Task], for indexPath: IndexPath) -> [UIDragItem] {
        let task = tasks[indexPath.row]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: task))
        dragItem.localObject = task
        return [dragItem]
    }
    
    private func toDoTask(index: Int) -> Task {
        return toDoList[index]
    }
    
    private func doingTask(index: Int) -> Task {
        return doingList[index]
    }
    
    private func doneTask(index: Int) -> Task {
        return doneList[index]
    }
    
    
    func moveTask(at sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath, in tableView: UITableView) {
        tableView.performBatchUpdates({
            switch tableView {
            case toDoTableView:
                let todoTask = toDoTask(index: sourceIndexPath.item)
                toDoList.remove(at: sourceIndexPath.item)
                toDoList.insert(todoTask, at: destinationIndexPath.item)
            case doingTableView:
                let doingTask = doingTask(index: sourceIndexPath.item)
                doingList.remove(at: sourceIndexPath.item)
                doingList.insert(doingTask, at: destinationIndexPath.item)
            case doneTableView:
                let doneTask = doneTask(index: sourceIndexPath.item)
                doneList.remove(at: sourceIndexPath.item)
                doneList.insert(doneTask, at: destinationIndexPath.item)
            
            default:
                break
            }
            tableView.deleteRows(at: [sourceIndexPath], with: .automatic)
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            
        })
    }
    
    func addTask(task: Task, destinationIndexPath: IndexPath, tableView: UITableView) {
        tableView.performBatchUpdates({
            switch tableView {
            case toDoTableView:
                toDoList.insert(task, at: destinationIndexPath.item)
            case doingTableView:
                doingList.insert(task, at: destinationIndexPath.item)
            case doneTableView:
                doneList.insert(task, at: destinationIndexPath.item)
            default:
                break
            }
            tableView.insertRows(at: [destinationIndexPath], with: .automatic)
            
        })
    }
    
    func deleteTask(at indexPath: IndexPath, in tableView: UITableView) {
        tableView.performBatchUpdates({
            switch tableView {
            case toDoTableView:
                toDoList.remove(at: indexPath.item)
            case doingTableView:
                doingList.remove(at: indexPath.item)
            case doneTableView:
                doneList.remove(at: indexPath.item)
            default:
                break
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        })
    }
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case toDoTableView:
            return self.toDoList.count
        case doingTableView:
            return self.doingList.count
        case doneTableView:
            return self.doneList.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case toDoTableView:
            guard let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            
            toDoCell.configure(tasks: self.toDoList, rowAt: indexPath.row)
            return toDoCell
            
        case doingTableView:
            guard let doingCell = tableView.dequeueReusableCell(withIdentifier: "doingCell", for: indexPath) as? DoingTableViewCell else { return  UITableViewCell() }
            doingCell.configure(tasks: self.doingList, rowAt: indexPath.row)
            return doingCell
            
        case doneTableView:
            guard let doneCell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? DoneTableViewCell else { return  UITableViewCell() }
            doneCell.configure(tasks: self.doneList, rowAt: indexPath.row)
            return doneCell
            
        default:
            return UITableViewCell()
        }
    }
}
