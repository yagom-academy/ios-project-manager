//
//  TaskListViewModel.swift
//  ProjectManager
//
//  Created by Harry, KokkiLE on 2023/05/17.
//

import Foundation

final class TaskListViewModel {
    var taskList = [Task]()
    
    init() {
        taskList.append(Task(state: .todo,
                             title: "임시 데이터",
                             body: "내용 없음",
                             deadline: Date()))
    }
}
