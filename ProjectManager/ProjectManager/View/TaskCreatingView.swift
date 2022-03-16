//
//  TaskCreatingView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/13.
//

import SwiftUI

struct TaskCreatingView: View {
    
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var isTaskCreating: Bool
    @State private var newTaskTitle: String = ""
    @State private var newTaskDueDate: Date = Date()
    @State private var newTaskBody: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $newTaskTitle)
                    .font(.title2)
                    .padding(.all, 10)
                    .border(.gray, width: 1)
                DatePicker("", selection: $newTaskDueDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .scaleEffect(1.2)
                    .padding(.vertical, 20)
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                TextEditorWithPlaceholder(taskBody: $newTaskBody)
            }
            .padding(.all, 20)
            .navigationTitle(TaskStatus.todo.headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            taskManager.createTask(title: newTaskTitle, body: newTaskBody, dueDate: newTaskDueDate)
                        }
                        isTaskCreating.toggle()
                    } label: {
                        Text("Done")
                    }
                    .disabled(!taskManager.validateNewTask(title: newTaskTitle, body: newTaskBody))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isTaskCreating.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .font(.title3)
        }
    }
}
