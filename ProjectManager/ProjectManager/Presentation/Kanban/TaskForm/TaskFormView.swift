//
//  TaskAddView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TaskFormView: View {    
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    @EnvironmentObject private var keyboard: KeyboardManager
    
    @ObservedObject private var taskFormViewModel: TaskFormViewModel    
    
    @FocusState private var textEditorIsFocused: Bool
    @Namespace private var textEditor
    
    init(title: String, size: CGSize) {
        self.taskFormViewModel = TaskFormViewModel(formTitle: title, formSize: size)
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        titleTextField
                        datePicker
                        contentTextEditor(proxy)
                        EmptySpaceForKeyboard
                    }
                    .padding()
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar { toolbarItems }
            .navigationTitle(taskFormViewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .cornerRadius(10)
        .frame(width: taskFormViewModel.formWidth, height: taskFormViewModel.formHeight)
    }
    
    var titleTextField: some View {
        TextField("제목을 입력하세요(필수)", text: $taskFormViewModel.title)
            .shadowBackground()
    }
    
    var datePicker: some View {
        DatePicker(
            "날짜를 입력하세요",
            selection: $taskFormViewModel.date,
            displayedComponents: .date
        )
        .datePickerStyle(.wheel)
        .labelsHidden()
    }
    
    func contentTextEditor(_ proxy: ScrollViewProxy) -> some View {
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
    var EmptySpaceForKeyboard: some View {
        if keyboard.isVisible {
            Spacer(minLength: keyboard.height)
        }
    }
    
    @ToolbarContentBuilder
    var toolbarItems: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Cancel") {
                kanbanViewModel.setFormVisible(false)
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Done") {
                let task = taskFormViewModel.task
                
                kanbanViewModel.create(task)
                kanbanViewModel.setFormVisible(false)
            }
            .disabled(taskFormViewModel.title.isEmpty)
        }
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView(title: "Todo", size: CGSize(width: 500, height: 600))
    }
}
