//
//  TaskListView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/08.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var taskViewModel: TaskViewModel
    @State private var isShowDetailScene: Bool = false
    @State private var isShowPopover: Bool = false
    let taskStatus: TaskStatus
    var tasks: [Task]
    
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
                        .sheet(isPresented: $isShowDetailScene, onDismiss: nil) {
                            DetailScene(task: task, showDetailScene: $isShowDetailScene)
                        }
                        .contextMenu {
                            TaskContextMenuView(task: task, taskStatus: taskStatus)
                        }
                        .environmentObject(taskViewModel)
                }
            }
            .onDelete { indexSet in
                self.taskViewModel.deleteTask(taskID: tasks[indexSet.first!].id)
            }
        }
    }
}
