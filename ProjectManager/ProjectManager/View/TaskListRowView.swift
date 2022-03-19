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
    @State private var isTaskStatusChanging: Bool = false
    
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
        .onLongPressGesture(perform: {
            isTaskStatusChanging.toggle()
        })
        // FIXME: popover 버튼이 눌리면, 모달이 즉시 사라지도록 만들어야 함. 애니메이션이 지속되는 동안 버튼이 여러 번 눌릴 수 있음.
        .popover(isPresented: $isTaskStatusChanging, content: {
            ZStack {
                Color(UIColor.quaternarySystemFill)
                    .scaleEffect(1.5)
                VStack(spacing: 6) {
                    ForEach(TaskStatus.allCases, id: \.self) { status in
                        if status != task.status {
                            Button {
                                withAnimation {
                                    taskManager.objectWillChange.send()
                                    try? taskManager.changeTaskStatus(target: task, to: status)
                                }
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
