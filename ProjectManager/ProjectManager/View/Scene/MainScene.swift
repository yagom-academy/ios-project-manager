//
//  ContentView.swift
//  ProjectManager
//
//  Created by 이호영 on 2022/03/01.
//

import SwiftUI

struct MainScene: View {
    @EnvironmentObject private var taskViewModel: TaskViewModel
    @State private var isShowAddScene: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                TaskListView(taskStatus: .todo, tasks: taskViewModel.todoTasks)
                TaskListView(taskStatus: .doing, tasks: taskViewModel.doingTasks)
                TaskListView(taskStatus: .done, tasks: taskViewModel.doneTasks)
            }
            .navigationBarTitle("Project Manager", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    AddButtonView(show: $isShowAddScene)
                        .sheet(isPresented: $isShowAddScene, onDismiss: nil) {
                            AddScene(showAddScene: $isShowAddScene)
                        }
                }
            }
        }.navigationViewStyle(.stack)
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = TaskRepository()
        let viewModel = TaskViewModel(taskRepository: repository)
        MainScene()
            .environmentObject(viewModel)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro (12.9-inch)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
