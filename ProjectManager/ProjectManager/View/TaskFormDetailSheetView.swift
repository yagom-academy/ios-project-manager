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
    @Binding var isShowSheet: Bool
    
    @State private var title: String
    @State private var date: Date
    @State private var description: String
    
    @State private var isEditingMode = false
    
    init(task: Task, isShowSheet: Binding<Bool>) {
        _isShowSheet = isShowSheet
        _title = State(initialValue: task.title)
        _date = State(initialValue: task.dueDate)
        _description = State(initialValue: task.description)
        self.task = task
    }
    
    var body: some View {
        NavigationView {
            TaskFormContainerView(title: $title, date: $date, description: $description)
                .padding()
                .disabled(!isEditingMode)
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
        }
        
    }
    
    private func toolbarTrailingButtonClicked() {
        if isEditingMode {
            updateTask()
        }
        toggleSheetCondition()
    }
    
    private func toolbarLeadingButtonClicked() {
        if isEditingMode {
            resetForm()
            UIApplication.shared.endEditing()
        }
        toggleSheetCondition()
    }
    
    private var toolbarButtonText: String {
        isEditingMode ? "Cancel" : "Edit"
    }
    
    private func resetForm() {
        title = task.title
        date = task.dueDate
        description = task.description
    }
    
    private func updateTask() {
        viewModel.update(
            task,
            title: $title.wrappedValue,
            description: $description.wrappedValue,
            dueDate: $date.wrappedValue
        )
    }
    
    private func toggleSheetCondition() {
        isShowSheet.toggle()
    }
    
}
