//
//  TaskListRowView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListRowView: View {
    
    @EnvironmentObject private var taskManager: TaskManager
    @ObservedObject var task: Task
    @State private var isTaskEditing: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(task.title)
                    .font(.title3)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(task.body)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Text(task.dueDate.dateString)
                    .font(.callout)
                    .foregroundColor(task.dueDate.isOverdue ? .red : .primary)
            }
            Spacer()
        }
        .padding(.all, 5)
        .contentShape(Rectangle())
        .onTapGesture {
            isTaskEditing.toggle()
        }
        .sheet(isPresented: $isTaskEditing) {
            TaskFormingView(selectedTask: task, mode: $isTaskEditing)
        }
        .contextMenu {
            ForEach(TaskStatus.allCases, id: \.self) { status in
                if status != task.status {
                    Button {
                        withAnimation {
                            taskManager.objectWillChange.send()
                            try? taskManager.changeTaskStatus(target: task, to: status)
                        }
                    } label: {
                        Text("Move to \(status.headerTitle)")
                    }
                }
            }
        }
    }
}
