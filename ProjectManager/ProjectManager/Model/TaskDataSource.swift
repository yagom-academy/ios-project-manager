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
    
    var model: [Task]? {
        switch self {
        case .todo:
            return self.taskArrayFromAsset()
        case .doing:
            return self.taskArrayFromAsset()
        case .done:
            return self.taskArrayFromAsset()
        }
    }
    
    private func taskArrayFromAsset() -> [Task]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        
        guard let dataAsset = NSDataAsset.init(name: self.description),
              let model = try? decoder.decode([Task].self, from: dataAsset.data) else { return nil }
        return model
    }
}

// MARK: - ParsingModel

final class TaskDataSource: NSObject, TaskTableViewDataSource {
    
    private var toDoList: [Task]
    private var doingList: [Task]
    private var doneList: [Task]
    
    override init() {
        super.init()
        if let toDoList = ProjectTaskType.todo.model,
           let doingList = ProjectTaskType.doing.model,
           let doneList = ProjectTaskType.done.model {
            self.toDoList = toDoList
            self.doingList = doingList
            self.doneList = doneList
        }
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
        default:
            return []
        }
    }
    
    private func createDragItem(tasks: [Task], for indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: tasks[indexPath.row]))
        dragItem.localObject = true
        return [dragItem]
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        switch tableView {
        case toDoTableView:
            return jsonDataManager.toDoList.count
        case doingTableView:
            return jsonDataManager.doingList.count
        case doneTableView:
            return jsonDataManager.doneList.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let jsonDataManager = jsonDataManager else { return UITableViewCell() }
        
        switch tableView {
        case toDoTableView:
            guard let toDoCell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as? ToDoTableViewCell else { return UITableViewCell() }
            
            toDoCell.configure(tasks: jsonDataManager.toDoList, rowAt: indexPath.row)
            return toDoCell
            
        case doingTableView:
            guard let doingCell = tableView.dequeueReusableCell(withIdentifier: "doingCell", for: indexPath) as? DoingTableViewCell else { return  UITableViewCell() }
            doingCell.configure(tasks: jsonDataManager.doingList, rowAt: indexPath.row)
            return doingCell
            
        case doneTableView:
            guard let doneCell = tableView.dequeueReusableCell(withIdentifier: "doneCell", for: indexPath) as? DoneTableViewCell else { return  UITableViewCell() }
            doneCell.configure(tasks: jsonDataManager.doneList, rowAt: indexPath.row)
            return doneCell
            
        default:
            return UITableViewCell()
        }
    }

}
