//
//  TaskDetailView.swift
//  ProjectManager
//
//  Created by JeongTaek Han on 2022/03/09.
//

import SwiftUI

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
                            isShowingSheet = false
                        }) {
                            Text("Done")
                        }
                    }
                }
        }
        
    }
    
}
