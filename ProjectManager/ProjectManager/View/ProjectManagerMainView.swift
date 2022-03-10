//
//  ProjectManagerMainView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/02/28.
//

import SwiftUI

struct ProjectManagerMainView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @StateObject private var sheetViewModel = TaskSheetViewModel()
    
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
                    .sheet(isPresented: $sheetViewModel.isShowSheet, onDismiss: nil) {
                        TaskFormCreateSheetView(sheetViewModel: sheetViewModel)
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func toggleSheetCondition() {
        sheetViewModel.toggleSheetCondition()
    }
    
}
