//
//  TaskFormCreateSheetView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskFormCreateSheetView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @ObservedObject var mainViewModel: ProjectManagerMainViewModel
    
    @State private var title = String()
    @State private var date = Date()
    @State private var description = String()
    
    var body: some View {
        NavigationView {
            TaskFormContainerView(title: $title, date: $date, description: $description)
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: mainViewModel.toggleSheetCondition) {
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
        mainViewModel.toggleSheetCondition()
    }
    
    private func createTask() {
        viewModel.create(
            title: title,
            description: description,
            dueDate: date
        )
    }
    
}
