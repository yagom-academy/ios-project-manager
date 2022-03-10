//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

struct TaskDetailView: View {
    
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
        let taskForm = TaskFormView(title: $title, date: $date, description: $description)
        
        NavigationView {
            taskForm
                .padding()
                .disabled(!isEditingMode)
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            if isEditingMode {
                                title = task.title
                                date = task.dueDate
                                description = task.description
                                UIApplication.shared.endEditing()
                            }
                            isEditingMode.toggle()
                        }) {
                            if isEditingMode {
                                Text("Cancel")
                            } else {
                                Text("Edit")
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            if isEditingMode {
                                viewModel.update(
                                    task,
                                    title: $title.wrappedValue,
                                    description: $description.wrappedValue,
                                    dueDate: $date.wrappedValue
                                )
                            }
                            isShowSheet = false
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}
