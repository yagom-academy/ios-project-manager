//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var viewModel: ProjectManagerViewModel
    @State var isShowDetailScene: Bool = false
    @State var isShowPopover: Bool = false
    let taskStatus: TaskStatus
    
    var tasks: [Task] {
        switch taskStatus {
        case .todo:
            return viewModel.todoTasks
        case .doing:
            return viewModel.doingTasks
        case .done:
            return viewModel.doneTasks
        }
    }
    
    var body: some View {
        VStack {
            listTitle
            list
        }
    }
    
    var listTitle: some View {
        HStack {
            Text(taskStatus.title)
                .font(.title)
            Spacer()
        }.padding()
    }
    
    var list: some View {
        List {
            ForEach(tasks) { task in
                Button {
                    self.isShowDetailScene.toggle()
                } label: {
                    TaskCellView(task: task)
                }.sheet(isPresented: $isShowDetailScene, onDismiss: nil) {
                    DetailScene(task: task, showDetailScene: $isShowDetailScene)
                        .contextMenu {
                            TaskContextMenuView(task: task, taskStatus: taskStatus)
                        }
                }
            }
            .onDelete { indexSet in
                self.viewModel.deleteTask(task: tasks[indexSet.first!])
            }
        }
    }
}
