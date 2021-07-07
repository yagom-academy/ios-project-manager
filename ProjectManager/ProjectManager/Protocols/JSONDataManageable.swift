//
//  MockJSONDatable.swift
//  ProjectManager
//
//  Created by James on 2021/07/06.
//

import Foundation

protocol JSONDataManageable {
    var toDoList: [Task] { get set }
    var doingList: [Task] { get set }
    var doneList: [Task] { get set }
    
    func fetchTaskList(task type: ProjectTaskType) -> [Task]
}
