//
//  TaskCreatingView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/27.
//

import SwiftUI

struct TaskCreatingView: View, TaskWritableView {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    @Binding var isShowingSheet: Bool
    
    @State private var newTask: Task = Task(title: "", description: "", dueDate: Date.now, status: .todo)
    
    var body: some View {
        VStack {
            datePickerView(withSelection: $newTask.dueDate)
            
            taskWritingViews(title: $newTask.title, description: $newTask.description)
            
            saveButton()
                .padding(.horizontal)
        }
    }
}

private extension TaskCreatingView {
    
    func saveButton() -> some View {
        SquareButtonView(label: "저장", color: Color.accentColor) {
            tasksDataSource.todoTasks.append(newTask)
            isShowingSheet.toggle()
        }
        .padding(.horizontal)
    }
}

struct TaskCreatingView_Previews: PreviewProvider {
    
    static var taskDashboardView = TaskDashboardView()
    
    static var previews: some View {
        TaskCreatingView(isShowingSheet: taskDashboardView.$isShowingSheet)
    }
}
