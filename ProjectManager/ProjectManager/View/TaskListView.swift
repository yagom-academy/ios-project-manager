//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/06.
//

import SwiftUI

struct TaskListView: View {
    
    let tasks: [Task]
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Text("TODO")
                    .font(.largeTitle)
                Circle()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(EdgeInsets(top: 11, leading: 21, bottom: -1, trailing: 21))
            List {
                ForEach(tasks) { task in
                    TaskListCellView(task: task)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.systemGray6))
    }
}
