//
//  ProjectManagerMainView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ProjectManagerMainView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @State private var isShowSheet = false
    
    var body: some View {
        
        NavigationView {
            HStack {
                ForEach(TaskStatus.allCases) { status in
                    TaskListContainerView(taskType: status)
                }
            }
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowSheet, onDismiss: nil) {
                        TaskCreateView(isShowSheet: $isShowSheet)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ProjectManagerViewModel()
        ProjectManagerMainView()
            .environmentObject(viewModel)
    }
    
}
