//
//  TaskAddView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct TaskFormView: View {    
    @EnvironmentObject private var kanbanViewModel: KanbanViewModel
    @ObservedObject private var taskFormViewModel: TaskFormViewModel
    
    @FocusState private var textEditorIsFocused: Bool
    @Namespace var textEditor
    init(title: String, size: CGSize) {
        self.taskFormViewModel = TaskFormViewModel(formTitle: title, formSize: size)
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack {
                        TextField("제목을 입력하세요(필수)", text: $taskFormViewModel.title)
                            .shadowBackground()
                        DatePicker(
                            "날짜를 입력하세요",
                            selection: $taskFormViewModel.date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                                                
                        TextEditor(text: $taskFormViewModel.content)
                            .focused($textEditorIsFocused)
                            .shadowBackground()
                            .frame(height: taskFormViewModel.formHeight * 0.5)
                            .id(textEditor)
                            .onChange(of: textEditorIsFocused) { isFocused in
                                if isFocused {
                                    withAnimation {
                                        proxy.scrollTo(textEditor, anchor: .center)
                                    }
                                } else {
                                    withAnimation {
                                        proxy.scrollTo(textEditor, anchor: .bottom)
                                    }
                                }
                            }
                    }
                    .padding()
                }
            }
            .toolbar {
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
            .navigationTitle(taskFormViewModel.formTitle)
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .cornerRadius(10)
        .frame(width: taskFormViewModel.formWidth, height: taskFormViewModel.formHeight)
    }
}

struct TaskAddView_Previews: PreviewProvider {
    static var previews: some View {
        TaskFormView(title: "Todo", size: CGSize(width: 500, height: 600))
    }
}
