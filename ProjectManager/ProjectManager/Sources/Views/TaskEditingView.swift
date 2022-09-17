//
//  TaskEditingView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/16.
//

import SwiftUI

struct TaskEditingView: View {
    
    @Binding var isShowingSheet: Bool
    @ObservedObject var taskDashboardViewModel: TaskDashboardViewModel
    @State private var task = Task(title: "", description: "", dueDate: Date.now, status: .todo)
    @State private var isEditingDisable = true
    @State var isNewTask: Bool
    
    var body: some View {
        VStack {
            HStack() {
                Image(systemName: "calendar")
                
                DatePicker("", selection: $task.dueDate, in: Date()..., displayedComponents: .date)
                    .labelsHidden()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal)
            
            Group {
                TextField("할 일의 제목을 입력해주세요", text: $task.title)
                TextField("필요한 경우 상세설명을 적어주세요", text: $task.description)
            }
            .disabled(isNewTask ? !isEditingDisable : isEditingDisable)
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
                    taskDashboardViewModel.todoTasks.append(task)
                    isShowingSheet.toggle()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    
    static var taskDashboardView = TaskDashboardView()
    
    static var previews: some View {
        TaskEditingView(isShowingSheet: taskDashboardView.$isShowingSheet, taskDashboardViewModel: TaskDashboardViewModel(), isNewTask: true)
    }
}
