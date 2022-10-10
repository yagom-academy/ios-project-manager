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
            
            cancelView()
        }
        .alert(isPresented: $tasksDataSource.shouldShowErrorAlert) {
            ErrorAlertManager.presentError()
        }
    }
}

private extension TaskEditingView {
    
    func saveButton() -> some View {
        SquareButtonView(label: "저장", color: Color.accentColor) {
            withAnimation(.spring())  {
                tasksDataSource.replaceOriginalTask(with: selectedTask)
            }
            isShowingSheet.toggle()
        }
    }
    
    func editButton() -> some View {
        let label = (isEditingDisable ? "편집모드 활성화" : "읽기전용모드 활성화")
        
        return SquareButtonView(label: label, color: .secondary) {
            isEditingDisable.toggle()
        }
    }
    
    func cancelView() -> some View {
        SquareButtonView(label: "취소", color: .secondary) {
            isShowingSheet.toggle()
        }
        .padding(.horizontal)
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    
    static var taskDashboardView = TaskDashboardView()
    @State static var dummyTask = Task(title: "Test Title", description: "Test Description", dueDate: Date.now, status: .todo)
    @State static var isShowingSheet = false
    
    static var previews: some View {
        TaskEditingView(isShowingSheet: $isShowingSheet, selectedTask: $dummyTask)
            
    }
}
