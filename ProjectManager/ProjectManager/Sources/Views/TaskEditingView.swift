//
//  TaskEditingView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct TaskEditingView: View {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    @Binding var isShowingSheet: Bool
    @Binding var selectedTask: Task
    
    @State private var isEditingDisable = true
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "calendar")
                
                DatePicker("", selection: $selectedTask.dueDate, in: Date()..., displayedComponents: .date)
                    .labelsHidden()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Group {
                TextField("할 일의 제목을 입력해주세요", text: $selectedTask.title)
                TextField("필요한 경우 상세설명을 적어주세요", text: $selectedTask.description)
            }
            .disabled(isEditingDisable)
            .padding(.horizontal)
            .frame(height: 55)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            HStack {
                SquareButtonView(label: "수정", color: .gray) {
                    isEditingDisable.toggle()
                }
                
                SquareButtonView(label: "저장", color: Color.accentColor) {
                    tasksDataSource.replaceOriginalTask(with: selectedTask)
                    isShowingSheet.toggle()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    
    static var taskDashboardView = TaskDashboardView()
    @State static var dummyTask = Task(title: "Test Title", description: "Test Description", dueDate: Date.now, status: .todo)
    
    static var previews: some View {
        TaskEditingView(isShowingSheet: taskDashboardView.$isShowingSheet, selectedTask: $dummyTask)
    }
}
