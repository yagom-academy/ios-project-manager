//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListView: View {
    
    let tasks: [Task]
    let taskStatus: TaskStatus
    var taskListHeader: String {
        switch taskStatus {
        case .todo:
            return "TODO"
        case .doing:
            return "DOING"
        case .done:
            return "DONE"
        }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text(taskListHeader)
                    .font(.largeTitle)
                Text(tasks.count / 100 < 1 ? "\(tasks.count)" : "99+")
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
                    Spacer()
                        .frame(height: 0)
                        .background(Color.clear)
                }
            }
            .listStyle(.plain)
            .environment(\.defaultMinListRowHeight, 0)
        }
        .background(Color(UIColor.systemGray6))
    }
}
