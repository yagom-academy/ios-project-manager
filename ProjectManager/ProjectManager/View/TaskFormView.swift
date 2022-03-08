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
        let taskForm = TaskFormView()
        
        NavigationView {
            taskForm
                .padding()
                .navigationTitle("TODO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if isEditingMode {
                            Button(action: {
                                isShowingSheet.toggle()
                            }) {
                                Text("Cancel")
                            }
                        } else {
                            Button(action: {
                                isEditingMode.toggle()
                            }) {
                                Text("Edit")
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingSheet.toggle()
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}

struct TaskFormView: View {
    
    @State var title = String()
    @State var date = Date()
    @State var description = String()
    
    init(task: Task? = nil) {
        self.title = task?.title ?? ""
        self.date = task?.dueDate ?? Date()
        self.description = task?.description ?? ""
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            titleField
            dueDatePicker
            descriptionEditor
        }
    }
    
    var titleField: some View {
        TextField("Text", text: $title)
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
