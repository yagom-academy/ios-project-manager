//
//  TaskCreatingView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/13.
//

import SwiftUI

struct TaskCreatingView: View {
    
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var isTaskCreatingViewShowing: Bool
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
                    .scaleEffect(1.4)
                    .padding(.vertical, 50)
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
                        isTaskCreatingViewShowing.toggle()
                    } label: {
                        Text("Done")
                    }
                    .disabled(!taskManager.validateNewTask(title: newTaskTitle, body: newTaskBody))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isTaskCreatingViewShowing.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .font(.title3)
        }
    }
}
