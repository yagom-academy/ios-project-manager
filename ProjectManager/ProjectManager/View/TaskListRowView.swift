//
//  TaskListRowView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListRowView: View {
    
    @EnvironmentObject private var taskManager: TaskManager
    @StateObject private var taskListRowViewModel: TaskListRowViewModel
    
    init(task: Task) {
        _taskListRowViewModel = StateObject(wrappedValue: TaskListRowViewModel(task: task))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(taskListRowViewModel.task.title)
                    .font(.title3)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(taskListRowViewModel.task.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Text(taskListRowViewModel.task.dueDate.dateString)
                    .font(.callout)
                    .foregroundColor(taskListRowViewModel.isOverdue ? .red : .primary)
            }
            Spacer()
        }
        .padding(.all, 5)
        .contentShape(Rectangle())
        .onTapGesture {
            taskListRowViewModel.isTaskEditing.toggle()
        }
        .sheet(isPresented: $taskListRowViewModel.isTaskEditing) {
            TaskFormingView(selectedTask: taskListRowViewModel.task, mode: $taskListRowViewModel.isTaskEditing)
        }
        .onLongPressGesture(perform: {
            taskListRowViewModel.isTaskStatusChanging.toggle()
        })
        .popover(isPresented: $taskListRowViewModel.isTaskStatusChanging, content: {
            ZStack {
                Color(UIColor.quaternarySystemFill)
                    .scaleEffect(1.5)
                VStack(spacing: 6) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        if status != taskListRowViewModel.task.status {
                            Button {
                                taskListRowViewModel.changeTaskStatus(to: status, using: taskManager)
                            } label: {
                                Text("Move to \(status.headerTitle)")
                                    .frame(width: 250, height: 50)
                                    .background(Color(UIColor.systemBackground))
                            }
                        }
                    }
                }
                .padding(.all, 10)
                .font(.title2)
            }
        })
    }
}

private extension TaskListRowView {
    
    final class TaskListRowViewModel: ObservableObject {
        
        @Published var task: Task
        @Published var isTaskEditing: Bool = false
        @Published var isTaskStatusChanging: Bool = false
        
        var isOverdue: Bool {
            return task.dueDate.isOverdue
        }
        
        init(task: Task) {
            _task = Published(wrappedValue: task)
        }
        
        func changeTaskStatus(to status: TaskStatus, using taskManager: TaskManager) {
            withAnimation {
                taskManager.objectWillChange.send()
                try? taskManager.changeTaskStatus(target: task, to: status)
                isTaskStatusChanging.toggle()
            }
        }
    }
}
