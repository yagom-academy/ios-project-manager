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
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @State private var isTextEditorFocused: Bool = false
    private var isRegularKeyboard: Bool {
        return keyboardResponder.currentHeight > 70
    }
    private var keyboardAdjustingPadding: CGFloat {
        switch (isTextEditorFocused, isRegularKeyboard) {
        case (true, true):
            return keyboardResponder.currentHeight
        case (false, true):
            return -keyboardResponder.currentHeight
        case (true, false):
            return 0
        case (false, false):
            return 0
        }
    }
    
    init(selectedTask: Task?, mode isModalShowing: Binding<Bool>) {
        self._isModalShowing = isModalShowing
        
        if let selectedTask = selectedTask {
            self.selectedTask = selectedTask
            _taskTitle = State(wrappedValue: selectedTask.title)
            _taskDueDate = State(wrappedValue: selectedTask.dueDate)
            _taskBody = State(wrappedValue: selectedTask.body)
        } else {
            self.selectedTask = nil
            _taskTitle = State(initialValue: "")
            _taskDueDate = State(initialValue: Date())
            _taskBody = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CustomTextField(taskTitle: $taskTitle)
                    .onTapGesture {
                        isTextEditorFocused = false
                    }
                DatePicker("", selection: $taskDueDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .scaleEffect(1.2)
                    .padding(.vertical, 20)
                    .environment(\.locale, Locale(identifier: Locale.preferredLanguages.first ?? "en"))
                TextEditorWithPlaceholder(taskBody: $taskBody)
                    .onTapGesture {
                        isTextEditorFocused = true
                    }
            }
            .padding(.all, 20)
            .padding(.bottom, keyboardAdjustingPadding)
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
                    .disabled(!taskManager.validateTask(title: taskTitle, body: taskBody))
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
