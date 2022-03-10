//
//  MainView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI

struct MainView: View {
    
    let taskManager: TaskManager
    
    var body: some View {
        NavigationView {
            HStack {
                TaskListView(tasks: taskManager.todoTasks, taskStatus: .todo)
                TaskListView(tasks: taskManager.todoTasks, taskStatus: .doing)
                TaskListView(tasks: taskManager.todoTasks, taskStatus: .done)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGray4))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                Button {
                    print("💚 할일 추가 버튼 눌림!") // TODO: 할일 추가 화면 연결
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
