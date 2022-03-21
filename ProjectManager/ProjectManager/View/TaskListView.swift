//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject var taskManager: TaskManager
    @StateObject private var taskListViewModel: TaskListViewModel
    
    init(taskStatus: TaskStatus) {
        _taskListViewModel = StateObject(wrappedValue: TaskListViewModel(taskStatus: taskStatus))
    }
    
    var body: some View {
        VStack {
            TaskListHeaderView(taskStatus: taskListViewModel.taskStatus, tasksCount: taskListViewModel.displayTasksCount(using: taskManager))
            if taskListViewModel.isTasksNotEmpty(using: taskManager) {
                List {
                    ForEach(taskListViewModel.fetchTasks(using: taskManager)) { task in
                        TaskListRowView(task: task)
                    }
                    .onDelete { indexSet in
                        taskListViewModel.deleteTask(indexSet: indexSet, using: taskManager)
                    }
                }
                .listStyle(.plain)
            } else {
                TaskListPlaceholder(taskStatus: taskListViewModel.taskStatus)
            }
        }
        .background(Color(UIColor.systemGray6))
    }
}

private extension TaskListView {
    
    final class TaskListViewModel: ObservableObject {
        
        let taskStatus: TaskStatus
        
        init(taskStatus: TaskStatus) {
            self.taskStatus = taskStatus
        }
        
        func displayTasksCount(using taskManager: TaskManager) -> String {
            let tasks = taskManager.fetchTasks(in: taskStatus)
            return tasks.count / 100 < 1 ? "\(tasks.count)" : "99+"
        }
        
        func isTasksNotEmpty(using taskManager: TaskManager) -> Bool {
            let tasks = taskManager.fetchTasks(in: taskStatus)
            return !tasks.isEmpty
        }
        
        func fetchTasks(using taskManager: TaskManager) -> [Task] {
            return taskManager.fetchTasks(in: taskStatus)
        }
        
        func deleteTask(indexSet: IndexSet, using taskManager: TaskManager) {
            try? taskManager.deleteTask(indexSet: indexSet, in: taskStatus)
        }
    }
}
