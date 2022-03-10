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
    @ObservedObject var sheetViewModel: TaskSheetViewModel
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                Button(action: sheetViewModel.toggleSheetCondition) {
                    TaskListRowView(task: task)
                        .contextMenu {
                            TaskListContextMenuView(task: task)
                        }
                        .sheet(isPresented: $sheetViewModel.isShowSheet, onDismiss: nil) {
                            TaskFormDetailSheetView(task: task, sheetViewModel: sheetViewModel)
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
    
}
