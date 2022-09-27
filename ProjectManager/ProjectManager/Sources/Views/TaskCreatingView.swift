//
//  TaskCreatingView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/27.
//

import SwiftUI

struct TaskCreatingView: View {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    @Binding var isShowingSheet: Bool
    
    @State private var newTask: Task = Task(title: "", description: "", dueDate: Date.now, status: .todo)
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "calendar")
                
                DatePicker("", selection: $newTask.dueDate, in: Date()..., displayedComponents: .date)
                    .labelsHidden()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Group {
                TextField("할 일의 제목을 입력해주세요", text: $newTask.title)
                TextField("필요한 경우 상세설명을 적어주세요", text: $newTask.description)
            }
            .padding(.horizontal)
            .frame(height: 55)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            SquareButtonView(label: "저장", color: Color.accentColor) {
                tasksDataSource.todoTasks.append(newTask)
                isShowingSheet.toggle()
            }
            .padding(.horizontal)
        }
    }
}

struct TaskCreatingView_Previews: PreviewProvider {
    
    static var taskDashboardView = TaskDashboardView()
    
    static var previews: some View {
        TaskCreatingView(isShowingSheet: taskDashboardView.$isShowingSheet)
    }
}
