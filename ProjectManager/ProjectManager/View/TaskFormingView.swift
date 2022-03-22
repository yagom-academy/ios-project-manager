//
//  TaskFormingView.swift
//  ProjectManager
//
//  Created by 예거 on 2022/03/14.
//

import SwiftUI

struct TaskFormingView: View {
    
    @EnvironmentObject private var taskManager: TaskManager
    @StateObject private var taskFormingViewModel: TaskFormingViewModel
    @StateObject private var keyboardResponder = KeyboardResponder()
    
    init(selectedTask: Task?, mode isModalShowing: Binding<Bool>) {
        _taskFormingViewModel = StateObject(wrappedValue: TaskFormingViewModel(selectedTask: selectedTask, mode: isModalShowing))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CustomTextField(taskTitle: $taskFormingViewModel.taskTitle)
                    .onTapGesture {
                        taskFormingViewModel.isTextEditorFocused = false
                    }
                CustomDatePicker(taskDueDate: $taskFormingViewModel.taskDueDate)
                TextEditorWithPlaceholder(taskBody: $taskFormingViewModel.taskBody)
                    .onTapGesture {
                        taskFormingViewModel.isTextEditorFocused = true
                    }
            }
            .padding(.all, 20)
            .padding(.bottom, taskFormingViewModel.addKeyboardAdjustingPadding(using: keyboardResponder))
            .navigationTitle(taskFormingViewModel.selectedTask?.status.headerTitle ?? TaskStatus.todo.headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        taskFormingViewModel.createOrEditTask(using: taskManager)
                    } label: {
                        Text(taskFormingViewModel.selectedTask == nil ? "Done" : "Edit")
                    }
                    .disabled(!taskFormingViewModel.validateTask(using: taskManager))
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        taskFormingViewModel.isModalShowing.toggle()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            .font(.title3)
            .alert(isPresented: $taskFormingViewModel.isErrorOccurred) {
                AlertManager.errorAlert
            }
        }
    }
}

private extension TaskFormingView {
    
    final class TaskFormingViewModel: ObservableObject {
        
        @Binding var isModalShowing: Bool
        @Published var selectedTask: Task?
        @Published var taskTitle: String
        @Published var taskDueDate: Date
        @Published var taskBody: String
        @Published var isTextEditorFocused: Bool = false
        @Published var isErrorOccurred: Bool = false
        
        init(selectedTask: Task?, mode isModalShowing: Binding<Bool>) {
            _isModalShowing = isModalShowing
            
            if let selectedTask = selectedTask {
                self.selectedTask = selectedTask
                _taskTitle = Published(wrappedValue: selectedTask.title)
                _taskDueDate = Published(wrappedValue: selectedTask.dueDate)
                _taskBody = Published(wrappedValue: selectedTask.body)
            } else {
                self.selectedTask = nil
                _taskTitle = Published(initialValue: "")
                _taskDueDate = Published(initialValue: Date())
                _taskBody = Published(initialValue: "")
            }
        }
        
        func createOrEditTask(using taskManager: TaskManager) {
            withAnimation {
                if selectedTask == nil {
                    taskManager.createTask(title: taskTitle, body: taskBody, dueDate: taskDueDate)
                } else {
                    taskManager.objectWillChange.send()
                    do {
                        try taskManager.editTask(target: selectedTask, title: taskTitle, body: taskBody, dueDate: taskDueDate)
                    } catch {
                        isErrorOccurred.toggle()
                    }
                }
            }
            isModalShowing.toggle()
        }
        
        func validateTask(using taskManager: TaskManager) -> Bool {
            return taskManager.validateTask(title: taskTitle, body: taskBody)
        }
        
        func addKeyboardAdjustingPadding(using keyboardResponder: KeyboardResponder) -> CGFloat {
            switch (isTextEditorFocused, isRegularKeyboard(using: keyboardResponder)) {
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
        
        private func isRegularKeyboard(using keyboardResponder: KeyboardResponder) -> Bool {
            return keyboardResponder.currentHeight > 70
        }
    }
}
