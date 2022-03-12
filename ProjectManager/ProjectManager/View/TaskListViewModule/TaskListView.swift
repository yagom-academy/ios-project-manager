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
    
    @Binding var isShowAlert: Bool
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                Button(action: sheetViewModel.toggleSheetCondition) {
                    TaskListRowView(task: task)
                        .contextMenu {
                            TaskListContextMenuView(task: task, isShowAlert: $isShowAlert)
                        }
                        .sheet(isPresented: $sheetViewModel.isShowSheet, onDismiss: nil) {
                            TaskFormDetailSheetView(task: task, sheetViewModel: sheetViewModel)
                        }
                }
            }
            .onDelete { indexSet in
                do {
                    try viewModel.remove(tasks[indexSet])
                } catch {
                    isShowAlert.toggle()
                }
            }
            .alert(isPresented: $isShowAlert) {
                Alert(
                    title: Text("update Task Failed"),
                    message: Text("Please retry update task!")
                )
            }
        }
    }
    
    private var tasks: [Task] {
        viewModel.findTasks(of: taskType)
    }
    
}
