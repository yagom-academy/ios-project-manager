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
    var tasks: [Task] {
        switch taskStatus {
        case .todo:
            return taskViewModel.todoTasks
        case .doing:
            return taskViewModel.doingTasks
        case .done:
            return taskViewModel.doneTasks
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
                        .sheet(isPresented: $isShowDetailScene, onDismiss: nil) {
                            DetailScene(task: task, showDetailScene: $isShowDetailScene)
                        }
                        .onLongPressGesture(minimumDuration: 0.5, maximumDistance: 10.0, perform: {
                            isShowPopover.toggle()
                        }, onPressingChanged: nil)
                        .popover(
                            isPresented: $isShowPopover,
                            attachmentAnchor: .rect(Anchor<CGRect>.Source.bounds),
                            content: {
                            TaskPopoverView {
                                self.taskViewModel.changeStatus(taskID: task.id, to: taskStatus.moveToStatus[0])
                            } firstButtonLabel: {
                                Text(taskStatus.moveToStatus[0].moveToText)
                                    .font(.system(size: 25))
                                    .frame(alignment: .center)
                            } secondsButtonAction: {
                                self.taskViewModel.changeStatus(taskID: task.id, to: taskStatus.moveToStatus[1])
                            } secondsButtonLabel: {
                                Text(taskStatus.moveToStatus[1].moveToText)
                                    .font(.system(size: 25))
                                    .frame(alignment: .center)
                            }
                            .frame(width: 280, height: 130)
                        })
                }
            }
            .onDelete { indexSet in
                self.taskViewModel.deleteTask(taskID: tasks[indexSet.first!].id)
            }
        }
    }
}
