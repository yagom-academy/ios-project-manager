//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/08.
//

import SwiftUI

struct TaskCreateView: View {
    
    @EnvironmentObject var viewModel: ProjectManagerViewModel
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        let taskForm = TaskFormView()
        
        NavigationView {
            taskForm
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            viewModel.create(
                                title: taskForm.title,
                                description: taskForm.description,
                                dueDate: taskForm.date
                            )
                            isShowingSheet.toggle()
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}

struct TaskDetailView: View {
    
    let task: Task
    
    @ObservedObject var viewModel: ProjectManagerViewModel
    @Binding var isShowingSheet: Bool
    
    @State var isEditingMode = false
    
    var body: some View {
        let taskForm = TaskFormView(task: task)
        
        NavigationView {
            taskForm
                .padding()
                .disabled(!isEditingMode)
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
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
                                isEditingMode.toggle()
                            } else {
                                isShowingSheet.toggle()
                            }
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}

struct TaskFormView: View {
    
    let task: Task? = nil
    
    @State var title: String
    @State var date: Date
    @State var description: String
    
    init(task: Task? = nil) {
        _title = State(initialValue: task?.title ?? "")
        _date = State(initialValue: task?.dueDate ?? Date())
        _description = State(initialValue: task?.description ?? "")
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            titleField
            dueDatePicker
            descriptionEditor
        }
    }
    
    var titleField: some View {
        TextField(task?.title ?? "Title", text: $title)
            .border(.gray)
    }
    
    var dueDatePicker: some View {
        DatePicker(
            "",
            selection: $date,
            displayedComponents: [.date]
        )
            .datePickerStyle(.wheel)
            .labelsHidden()
    }
    
    var descriptionEditor: some View {
        TextEditor(text: $description)
            .shadow(radius: 5)
    }
    
}
