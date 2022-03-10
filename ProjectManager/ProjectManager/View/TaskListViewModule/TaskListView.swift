//
//  TaskListView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/10.
//

import SwiftUI

struct TaskListView: View {
    
    let taskType: TaskStatus
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @Binding var isShowSheet: Bool
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                Button(action: toggleSheetCondition) {
                    TaskListRowView(task: task)
                        .contextMenu {
                            TaskListContextMenuView(task: task)
                        }
                        .sheet(isPresented: $isShowSheet, onDismiss: nil) {
                            TaskFormDetailSheetView(task: task, isShowSheet: $isShowSheet)
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
    
    private func toggleSheetCondition() {
        isShowSheet.toggle()
    }
    
}
