//
//  TaskFormCreateSheetView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskFormCreateSheetView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @ObservedObject var sheetViewModel: TaskSheetViewModel
    @StateObject var createViewModel = TaskFormViewModel()
    
    var body: some View {
        NavigationView {
            TaskFormContainerView(formViewModel: createViewModel)
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: sheetViewModel.toggleSheetCondition) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: createButtonClicked) {
                            Text("Done")
                        }
                    }
                }
        }
    }
    
    private func createButtonClicked() {
        createTask()
        sheetViewModel.toggleSheetCondition()
    }
    
    private func createTask() {
        viewModel.create(
            title: createViewModel.title,
            description: createViewModel.description,
            dueDate: createViewModel.date
        )
    }
    
}
