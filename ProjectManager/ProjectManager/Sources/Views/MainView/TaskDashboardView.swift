//
//  TaskDashboardView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskDashboardView: View {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    @State private var isShowingSheet = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            HStack {
                TaskListView(status: .todo, tasks: $tasksDataSource.todoTasks)
                TaskListView(status: .doing, tasks: $tasksDataSource.doingTasks)
                TaskListView(status: .done, tasks: $tasksDataSource.doneTasks)
            }.padding()
            
            addingTaskButton()
        }
    }
}

private extension TaskDashboardView {
    
    func addingTaskButton() -> some View {
        return Button {
            isShowingSheet.toggle()
        } label: {
            Circle()
                .overlay(alignment: .bottomTrailing) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .padding()
                }
                .frame(width: 70, height: 70, alignment: .bottomTrailing)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 40))
        }
        .sheet(isPresented: $isShowingSheet) {
            TaskCreatingView(isShowingSheet: $isShowingSheet)
        }
    }
}

struct TaskDashboardView_Previews: PreviewProvider {
    
    static var previews: some View {
        TaskDashboardView()
            .environmentObject(TasksDataSource())
    }
}
