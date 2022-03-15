//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject private var taskManager: TaskManager

    let taskStatus: TaskStatus
    private var tasks: [Task] {
        switch taskStatus {
        case .todo:
            return taskManager.todoTasks
        case .doing:
            return taskManager.doingTasks
        case .done:
            return taskManager.doneTasks
        }
    }
    private var tasksCount: String {
        return tasks.count / 100 < 1 ? "\(tasks.count)" : "99+"
    }
    private var isTasksNotEmpty: Bool {
        return !tasks.isEmpty
    }
    
    var body: some View {
        VStack {
            TaskListHeaderView(taskStatus: taskStatus, tasksCount: tasksCount)
            if isTasksNotEmpty {
                List {
                    ForEach(tasks) { task in
                        TaskListRowView(task: task)
                    }
                    .onDelete { indexSet in
                        guard let targetIndex = indexSet.first else { return }
                        try? taskManager.deleteTask(target: tasks[targetIndex])
                    }
                }
                .listStyle(.plain)
            } else {
                TaskListPlaceholder(taskStatus: taskStatus)
            }
        }
        .background(Color(UIColor.systemGray6))
    }
}
