//
//  TaskListContextMenuView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListContextMenuView: View {
    
    let task: Task
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    
    var body: some View {
        ForEach(TaskStatus.allCases) { status in
            if status != task.status {
                Button(action: {
                    updateTaskStatus(to: status)
                }) {
                    Text("Move to \(status.description)")
                }
            }
        }
    }
    
    private func updateTaskStatus(to status: TaskStatus) {
        viewModel.update(task, taskStatus: status)
    }
    
}
