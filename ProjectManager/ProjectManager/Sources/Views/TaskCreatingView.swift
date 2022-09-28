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
                    .environment(\.locale, Locale.init(identifier: "ko"))
                    .labelsHidden()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            .padding(.bottom, 1)
            
            Group {
                TextField("할 일의 제목을 입력해주세요", text: $newTask.title)
                    .frame(height: 55)
                    .padding(.horizontal, 4)
                
                TaskDescriptionView(description: $newTask.description)
                    .frame(maxHeight: 500)
                    .padding(.top, 10)
                    .overlay(alignment: .topLeading) {
                        if newTask.description.isEmpty {
                            Text("필요한 경우 상세설명을 적어주세요")
                                .foregroundColor(.gray.opacity(0.5))
                                .padding(.top, 20)
                        }
                    }
            }
            .padding(.horizontal)
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
