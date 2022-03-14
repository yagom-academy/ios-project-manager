//
//  MainView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI

struct MainView: View {
    
    @State private var isTaskCreatingViewShowing: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                TaskListView(taskStatus: .todo)
                TaskListView(taskStatus: .doing)
                TaskListView(taskStatus: .done)
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGray4))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                Button {
                    isTaskCreatingViewShowing.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isTaskCreatingViewShowing) {
                    TaskCreatingView(isTaskCreatingViewShowing: $isTaskCreatingViewShowing)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
