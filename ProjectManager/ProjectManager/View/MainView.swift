//
//  MainView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI

struct MainView: View {
    
    @State private var isTaskCreating: Bool = false
    
    var body: some View {
        NavigationView {
            HStack {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    TaskListView(taskStatus: status)
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemGray4))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                Button {
                    isTaskCreating.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .sheet(isPresented: $isTaskCreating) {
                    TaskFormingView(selectedTask: nil, mode: $isTaskCreating)
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarAppearance(font: .headline, foregroundColor: .label, hideSeparator: true)
    }
}
