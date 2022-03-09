//
//  TaskContextMenuView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/09.
//

import SwiftUI

struct TaskContextMenuView: View {
    @EnvironmentObject private var taskViewModel: TaskViewModel
    @ObservedObject var task: Task
    var taskStatus: TaskStatus
    
    var body: some View {
        Button {
            self.taskViewModel.changeStatus(task: task, to: taskStatus.moveToStatus[0])
        } label: {
            Text(taskStatus.moveToStatus[0].moveToText)
        }
        Button {
            self.taskViewModel.changeStatus(task: task, to: taskStatus.moveToStatus[1])
        } label: {
            Text(taskStatus.moveToStatus[1].moveToText)
        }
    }
}
