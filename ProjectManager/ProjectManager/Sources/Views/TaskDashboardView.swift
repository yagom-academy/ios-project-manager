//
//  TaskDashboardView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskDashboardView: View {
    
    @StateObject var taskDashboardViewModel = TaskDashboardViewModel()
    
    var body: some View {
        HStack {
            TaskListView(status: .todo, tasks: $taskDashboardViewModel.todoTasks)
            TaskListView(status: .doing, tasks: $taskDashboardViewModel.doingTasks)
            TaskListView(status: .done, tasks: $taskDashboardViewModel.doneTasks)
        }
    }
}

struct TaskDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDashboardView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
