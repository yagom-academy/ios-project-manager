//
//  TaskEditingView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct TaskEditingView: View, TaskWritableView {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    @Binding var isShowingSheet: Bool
    @Binding var selectedTask: Task
    
    @State private var isEditingDisable = true
    
    var body: some View {
        VStack {
            Group {
                datePickerView(withSelection: $selectedTask.dueDate)
                
                taskWritingViews(title: $selectedTask.title, description: $selectedTask.description)
            }
            .disabled(isEditingDisable)
            
            HStack {
                editButton()
                
                saveButton()
            }
            .padding(.horizontal)
        }
    }
}

private extension TaskEditingView {
    
    func saveButton() -> some View {
        SquareButtonView(label: "저장", color: Color.accentColor) {
            tasksDataSource.replaceOriginalTask(with: selectedTask)
            isShowingSheet.toggle()
        }
    }
    
    func editButton() -> some View {
        SquareButtonView(label: "수정", color: .secondary) {
            isEditingDisable.toggle()
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
