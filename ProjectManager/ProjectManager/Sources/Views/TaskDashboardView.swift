//
//  TaskDashboardView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskDashboardView: View {
    
    @StateObject var taskDashboardViewModel = TaskDashboardViewModel()
    @State var isShowingSheet = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack {
                TaskListView(status: .todo, tasks: $taskDashboardViewModel.todoTasks)
                TaskListView(status: .doing, tasks: $taskDashboardViewModel.doingTasks)
                TaskListView(status: .done, tasks: $taskDashboardViewModel.doneTasks)
            }.padding()
            
            Button {
                isShowingSheet.toggle()
            } label: {
                AddingTaskButtonView()
                    .frame(width: 70, height: 70, alignment: .bottomTrailing)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
            }
            .sheet(isPresented: $isShowingSheet) {
                TaskEditingView(isShowingSheet: $isShowingSheet, taskDashboardViewModel: taskDashboardViewModel, isNewTask: true)
            }
        }
    }
}

struct TaskDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDashboardView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
