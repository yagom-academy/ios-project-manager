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
        List {
            ForEach(tasks) { task in
                TaskListCellView(task: task)
            }
        }
        .listStyle(.grouped)
    }
}
