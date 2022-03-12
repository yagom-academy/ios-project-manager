//
//  TaskFormDetailSheetView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskFormDetailSheetView: View {
    
    let task: Task
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @ObservedObject private var detailViewModel: TaskFormViewModel
    @ObservedObject var sheetViewModel: TaskSheetViewModel
    
    @State private var isShowAlert = false
    
    init(task: Task, sheetViewModel: TaskSheetViewModel) {
        detailViewModel = TaskFormViewModel(task: task)
        self.sheetViewModel = sheetViewModel
        self.task = task
    }
    
    var body: some View {
        NavigationView {
            TaskFormContainerView(formViewModel: detailViewModel)
                .padding()
                .disabled(detailViewModel.isReadOnlyMode)
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: toolbarLeadingButtonClicked) {
                            Text(toolbarButtonText)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: toolbarTrailingButtonClicked) {
                            Text("Done")
                        }
                    }
                }
                .alert(isPresented: $isShowAlert) {
                    Alert(
                        title: Text("Update Task Failed"),
                        message: Text("Please retry update task!")
                    )
                }
                
        }
    }
    
    private func toolbarTrailingButtonClicked() {
        if detailViewModel.isEditingMode {
            updateTask()
        }
        sheetViewModel.toggleSheetCondition()
    }
    
    private func toolbarLeadingButtonClicked() {
        detailViewModel.changeEditingMode(with: task) {
            UIApplication.shared.endEditing()
        }
    }
    
    private var toolbarButtonText: String {
        detailViewModel.isEditingMode ? "Cancel" : "Edit"
    }
    
    private func updateTask() {
        do {
            try viewModel.update(
                task,
                title: detailViewModel.title,
                description: detailViewModel.description,
                dueDate: detailViewModel.date
            )
        } catch {
            isShowAlert.toggle()
        }
    }
    
}
