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
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text(taskStatus.headerTitle)
                    .font(.largeTitle)
                Text(tasksCount)
                    .frame(width: 30, height: 24)
                    .font(.title3)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .colorInvert()
                    .padding(.all, 5)
                    .background(Color.primary)
                    .clipShape(Circle())
                    .minimumScaleFactor(0.8)
                Spacer()
            }
            .padding(EdgeInsets(top: 11, leading: 21, bottom: -1, trailing: 21))
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
        }
        .background(Color(UIColor.systemGray6))
    }
}
