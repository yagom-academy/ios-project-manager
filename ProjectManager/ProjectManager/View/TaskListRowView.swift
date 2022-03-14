//
//  TaskListRowView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListRowView: View {
    
    @ObservedObject var task: Task
    @State private var isTaskEditingViewShowing: Bool = false
    
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
            isTaskEditingViewShowing.toggle()
        }
        .sheet(isPresented: $isTaskEditingViewShowing) {
            TaskEditingView(selectedTask: task, isTaskEditingViewShowing: $isTaskEditingViewShowing)
        }
    }
}
