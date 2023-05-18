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
        taskList.append(Task(state: .todo,
                             title: "투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트",
                             body: "투두투두11",
                             deadline: Date()))
        taskList.append(Task(state: .todo,
                             title: "투두222222222테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트투두1테스트",
                             body: "투두투두11",
                             deadline: Date()))
    }
}
