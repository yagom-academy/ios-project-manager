//
//  ProjectManagerMainView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ProjectManagerMainView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @StateObject private var mainViewModel = ProjectManagerMainViewModel()
    
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
                    Button(action: toggleSheetCondition) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $mainViewModel.isShowSheet, onDismiss: nil) {
                        TaskFormCreateSheetView(mainViewModel: mainViewModel)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
    
    private func toggleSheetCondition() {
        mainViewModel.toggleSheetCondition()
    }
    
}
