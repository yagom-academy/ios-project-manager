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
    
    private var tasks: [Task] {
        switch taskType {
        case .todo:
            return viewModel.todoTasks
        case .doing:
            return viewModel.doingTasks
        case .done:
            return viewModel.doneTasks
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            taskList
        }
    }
    
    private var title: some View {
        HStack {
            Text(taskType.description)
                .font(.largeTitle)
                .padding([.leading])
            
            Text(String(tasks.count))
                .font(.headline)
                .colorInvert()
                .padding(10)
                .background(Circle())
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
