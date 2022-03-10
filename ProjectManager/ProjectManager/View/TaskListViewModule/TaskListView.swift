//
//  TaskListView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    
    let taskType: TaskStatus
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @State private var isShowSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            TaskListTitleView(taskType: taskType)
            taskList
        }
    }
    
    private var taskList: some View {
        List {
            ForEach(tasks) { task in
                Button(action: {
                    self.isShowSheet.toggle()
                }) {
                    TaskRowView(task: task)
                        .contextMenu {
                            contextMenuView(task, taskType)
                        }
                        .sheet(isPresented: $isShowSheet, onDismiss: nil) {
                            TaskDetailView(
                                task: task,
                                isShowSheet: $isShowSheet
                            )
                        }
                }
            }
            .onDelete { indexSet in
                viewModel.remove(tasks[indexSet])
            }
        }
        
    }
    
    private var tasks: [Task] {
        viewModel.findTasks(of: taskType)
    }
    
    private func contextMenuView(_ task: Task, _ taskType: TaskStatus) -> some View {
        ForEach(TaskStatus.allCases) { status in
            if status != taskType {
                Button(action: { viewModel.update(task, taskStatus: status) }) {
                    Text("Move to \(status.description)")
                }
            }
        }
    }
    
}
