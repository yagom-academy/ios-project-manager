//
//  TaskEditingView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/14.
//

import SwiftUI

struct TaskEditingView: View {
    
    let selectedTask: Task
    
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var isTaskEditingViewShowing: Bool
    @State private var newTaskTitle: String
    @State private var newTaskDueDate: Date
    @State private var newTaskBody: String
    
    init(selectedTask: Task, isTaskEditingViewShowing: Binding<Bool>) {
        self.selectedTask = selectedTask
        self._isTaskEditingViewShowing = isTaskEditingViewShowing
        _newTaskTitle = State(wrappedValue: selectedTask.title)
        _newTaskDueDate = State(wrappedValue: selectedTask.dueDate)
        _newTaskBody = State(wrappedValue: selectedTask.body)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(newTaskTitle, text: $newTaskTitle)
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
            .navigationTitle(selectedTask.status.headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            taskManager.objectWillChange.send()
                            try? taskManager.editTask(target: selectedTask, title: newTaskTitle, body: newTaskBody, dueDate: newTaskDueDate)
                        }
                        isTaskEditingViewShowing.toggle()
                    } label: {
                        Text("Edit")
                    }
                    .disabled(!taskManager.validateNewTask(title: newTaskTitle, body: newTaskBody))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isTaskEditingViewShowing.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .font(.title3)
        }
    }
}
