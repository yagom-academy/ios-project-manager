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
    @State private var newTaskBody: String = "입력 가능한 글자수는 1,000자로 제한합니다."
    
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
                TextEditor(text: $newTaskBody)
                    .font(.title2)
                    .padding(.all, 10)
                    .border(.gray, width: 1)
            }
            .padding(.all, 20)
            .navigationTitle(TaskStatus.todo.headerTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Done 버튼 눌림!")
                    } label: {
                        Text("Done")
                    }
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
