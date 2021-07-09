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

final class JSONDataManager: JSONDataManageable {
    
    var toDoList: [Task]
    var doingList: [Task]
    var doneList: [Task]
    
    init?() {
        if let toDoList = ProjectTaskType.todo.model,
           let doingList = ProjectTaskType.doing.model,
           let doneList = ProjectTaskType.done.model {
            self.toDoList = toDoList
            self.doingList = doingList
            self.doneList = doneList
        } else { return nil }
    }
    
    func fetchTaskList(task type: ProjectTaskType) -> [Task] {
        switch type {
        case .todo:
            return toDoList
        case .doing:
            return doingList
        case .done:
            return doneList
        }
    }
}
