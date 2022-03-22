//
//  MainView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/02/28.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainViewModel = MainViewModel()
    
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
                    mainViewModel.isTaskCreating.toggle()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2)
                }
                .sheet(isPresented: $mainViewModel.isTaskCreating) {
                    TaskFormingView(selectedTask: nil, mode: $mainViewModel.isTaskCreating)
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationBarAppearance(font: .headline, foregroundColor: .label, hideSeparator: true)
    }
}

private extension MainView {
    
    final class MainViewModel: ObservableObject {
        
        @Published var isTaskCreating: Bool = false
    }
}
