//
//  TaskFormCreateSheetView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskFormCreateSheetView: View {
    
    @EnvironmentObject private var viewModel: ProjectManagerViewModel
    @StateObject var createViewModel = TaskFormViewModel()
    
    @Binding var isShowSheet: Bool
    @State private var isShowAlert = false
    
    var body: some View {
        NavigationView {
            TaskFormContainerView(formViewModel: createViewModel)
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { isShowSheet.toggle() }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: createButtonClicked) {
                            Text("Done")
                        }
                    }
                }
                .alert(isPresented: $isShowAlert) {
                    Alert(
                        title: Text("Create Task Failed"),
                        message: Text("Please retry create task!")
                    )
                }
        }
    }
    
    private func createButtonClicked() {
        createTask()
        isShowSheet.toggle()
    }
    
    private func createTask() {
        do {
            try viewModel.create(
                title: createViewModel.title,
                description: createViewModel.description,
                dueDate: createViewModel.date
            )
        } catch {
            isShowAlert.toggle()
        }
    }
    
}
