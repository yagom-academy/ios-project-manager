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
    
    @State var title = String()
    @State var date = Date()
    @State var description = String()
    
    var body: some View {
        let taskForm = TaskFormView(title: $title, date: $date, description: $description)
        
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
    
    @EnvironmentObject var viewModel: ProjectManagerViewModel
    @Binding var isShowingSheet: Bool
    
    @State var title: String
    @State var date: Date
    @State var description: String
    
    @State var isEditingMode = false
    
    init(task: Task, isShowingSheet: Binding<Bool>) {
        _isShowingSheet = isShowingSheet
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
    
    @Binding var title: String
    @Binding var date: Date
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            titleField
            dueDatePicker
            descriptionEditor
        }
    }
    
    var titleField: some View {
        TextField("Title", text: $title)
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
