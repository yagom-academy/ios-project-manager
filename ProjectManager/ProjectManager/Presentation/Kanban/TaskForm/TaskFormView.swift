//
//  TaskAddView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TaskFormView<TaskFormViewModel: TaskFormProtocol>: View {
    @EnvironmentObject private var taskManager: TaskManager
    @EnvironmentObject private var historyManager: HistoryManager
    @EnvironmentObject private var keyboardManager: KeyboardManager
    
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    @ObservedObject private var taskFormViewModel: TaskFormViewModel
    
    @FocusState private var textEditorIsFocused: Bool
    @Namespace private var textEditor
    
    init(_ viewModel: TaskFormViewModel) {
        self.taskFormViewModel = viewModel        
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        titleTextField
                        datePicker
                        contentTextEditor(proxy)
                        emptySpaceForKeyboard                            
                    }
                    .disabled(!taskFormViewModel.isEditable)
                    .padding()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle(taskFormViewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if taskFormViewModel.formMode == .create {
                    createToolbarItems
                } else {
                    editToolbarItems
                }
            }
        }
        .cornerRadius(10)
        .frame(width: taskFormViewModel.formWidth, height: taskFormViewModel.formHeight)
    }
    
    private var titleTextField: some View {
        TextField("제목을 입력하세요(필수)", text: $taskFormViewModel.title)
            .shadowBackground()
    }
    
    private var datePicker: some View {
        DatePicker(
            "날짜를 입력하세요",
            selection: $taskFormViewModel.date,
            displayedComponents: .date
        )
        .datePickerStyle(.wheel)
        .labelsHidden()
    }
    
    private func contentTextEditor(_ proxy: ScrollViewProxy) -> some View {
        TextEditor(text: $taskFormViewModel.content)
            .focused($textEditorIsFocused)
            .shadowBackground()
            .frame(height: taskFormViewModel.formHeight * 0.5)
            .id(textEditor)
            .onChange(of: textEditorIsFocused) { IsFocused in
                if IsFocused {
                    withAnimation {
                        proxy.scrollTo(textEditor, anchor: UnitPoint(x: 0, y: 0.05))
                    }
                } else {
                    withAnimation {
                        proxy.scrollTo(textEditor, anchor: .bottom)
                    }
                }
            }
    }
    
    @ViewBuilder
    private var emptySpaceForKeyboard: some View {
        if keyboardManager.isVisible {
            Spacer(minLength: keyboardManager.height)
        }
    }
    
    @ToolbarContentBuilder
    private var createToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                kanbanViewModel.setFormVisible(false)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
                let task = taskFormViewModel.task
                
                taskManager.create(task)
                
                historyManager.save(type: .added, task: task)
                
                kanbanViewModel.setFormVisible(false)
            }
            .disabled(taskFormViewModel.title.isEmpty)
        }
    }
    
    @ToolbarContentBuilder
    private var editToolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Edit") {
                taskFormViewModel.isEditable = true
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
                let task = taskFormViewModel.task
                
                taskManager.update(newTask: task)
                kanbanViewModel.setFormVisible(nil)
            }
        }
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView(
            TaskCreateViewModel(
                formSize: CGSize(width: 500, height: 600)
            )
        )
    }
}
