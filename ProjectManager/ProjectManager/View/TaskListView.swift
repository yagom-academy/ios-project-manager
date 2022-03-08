//
//  TaskListView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    
    let name: String
    let taskType: TaskStatus
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
//    @Binding var isShowingSheet: Bool
    @State var isShowingSheet = false
    
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
    
    var title: some View {
        HStack {
            Text(name)
                .font(.largeTitle)
                .padding([.leading])
            
            Text(String(tasks.count))
                .font(.headline)
                .colorInvert()
                .padding(10)
                .background(Circle())
        }
    }
    
    var taskList: some View {
        List {
            ForEach(tasks) { task in
                Button(action: {
                    self.isShowingSheet.toggle()
                }) {
                    TaskRowView(task: task)
                        .contextMenu {
                            contextMenuView(task, taskType)
                        }
                        .sheet(isPresented: $isShowingSheet, onDismiss: nil) {
                            TaskDetailView(
                                task: task,
                                viewModel: viewModel,
                                isShowingSheet: $isShowingSheet
                            )
                        }
                }
            }
            .onDelete { indexSet in
                viewModel.remove(tasks[indexSet])
            }
        }
        
    }
    
    func contextMenuView(_ task: Task, _ taskType: TaskStatus) -> some View {
        ForEach(TaskStatus.allCases) { status in
            if status != taskType {
                Button(action: { viewModel.update(task, taskStatus: status) }) {
                    Text("Move to \(status.description)")
                }
            }
        }
    }
    
}
