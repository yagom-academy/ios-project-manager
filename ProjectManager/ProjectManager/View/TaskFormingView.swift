//
//  TaskFormingView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/14.
//

import SwiftUI

struct TaskFormingView: View {
    
    let selectedTask: Task?
    
    @EnvironmentObject private var taskManager: TaskManager
    @Binding var isModalShowing: Bool
    @State private var taskTitle: String
    @State private var taskDueDate: Date
    @State private var taskBody: String
    
    init(selectedTask: Task?, mode isModalShowing: Binding<Bool>) {
        self._isModalShowing = isModalShowing
        
        if let selectedTask = selectedTask {
            // selectedTask 가 nil 이 아닌 경우
            self.selectedTask = selectedTask
            _taskTitle = State(wrappedValue: selectedTask.title)
            _taskDueDate = State(wrappedValue: selectedTask.dueDate)
            _taskBody = State(wrappedValue: selectedTask.body)
        } else {
            // selectedTask 가 nil 인 경우
            self.selectedTask = nil
            _taskTitle = State(initialValue: "")
            _taskDueDate = State(initialValue: Date())
            _taskBody = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(taskTitle, text: $taskTitle)
                    .font(.title2)
                    .padding(.all, 10)
                    .border(.gray, width: 1)
                DatePicker("", selection: $taskDueDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .scaleEffect(1.2)
                    .padding(.vertical, 20)
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                TextEditorWithPlaceholder(taskBody: $taskBody)
            }
            .padding(.all, 20)
            .navigationTitle(selectedTask?.status.headerTitle ?? TaskStatus.todo.headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation {
                            if selectedTask == nil {
                                taskManager.createTask(title: taskTitle, body: taskBody, dueDate: taskDueDate)
                            } else {
                                taskManager.objectWillChange.send()
                                try? taskManager.editTask(target: selectedTask, title: taskTitle, body: taskBody, dueDate: taskDueDate)
                            }
                        }
                        isModalShowing.toggle()
                    } label: {
                        Text(selectedTask == nil ? "Done" : "Edit")
                    }
                    .disabled(!taskManager.validateNewTask(title: taskTitle, body: taskBody))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isModalShowing.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .font(.title3)
        }
    }
}
