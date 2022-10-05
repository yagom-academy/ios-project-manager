//
//  TaskListView.swift
//  ProjectManager
//
//  Created by minsson on 2022/09/15.
//

import SwiftUI

struct TaskListView: View {
    
    @EnvironmentObject private var tasksDataSource: TasksDataSource
    
    var status: Status
    @Binding var tasks: [Task]
    
    @State private var isShowingEditingView = false
    @State private var selectedTask: Task = Task(title: "", description: "", dueDate: Date.now, status: .todo)
    
    var body: some View {
        VStack {
            TaskListHeaderView(status: status, taskCount: tasks.count)
            
            List {
                ForEach(tasks) { task in
                    TaskCellView(task: task)
                        .onTapGesture {
                            selectedTask = task
                            isShowingEditingView.toggle()
                        }
                        .swipeActions(edge: .leading) {
                            switch status {
                            case .todo:
                                swipeButtonForChangingStatus(of: task, to: .doing)
                                swipeButtonForChangingStatus(of: task, to: .done)
                            case .doing:
                                swipeButtonForChangingStatus(of: task, to: .todo)
                                swipeButtonForChangingStatus(of: task, to: .done)
                            case .done:
                                swipeButtonForChangingStatus(of: task, to: .todo)
                                swipeButtonForChangingStatus(of: task, to: .doing)
                            }
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing) {
                            swipeButtonForDeletion(of: task)
                        }
                }
                .onDelete { indexSet in
                    tasks.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $isShowingEditingView) {
                TaskEditingView(isShowingSheet: $isShowingEditingView, selectedTask: $selectedTask)
            }
        }
    }
}

private extension TaskListView {
    
    func swipeButtonForChangingStatus(of task: Task, to status: Status) -> some View {
        return Button {
            withAnimation(.spring()) {
                tasksDataSource.transfer(selectedTask: task, to: status)
            }
        } label: {
            Label("Move to\n\(status.description)", systemImage: status.image)
        }
        .tint(Color(status.color))
    }
    
    func swipeButtonForDeletion(of task: Task) -> some View {
        Button(role: .destructive) {
            withAnimation(.spring())  {
                tasksDataSource.deleteOriginalTask(equivalentTo: task)
            }
        } label: {
            Label("Delete", systemImage: "trash.circle.fill")
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    
    @State static var dummyTodoTasks: [Task] = [
        Task(title: "Title 1", description: "Description 1", dueDate: Date.now, status: .todo),
        Task(title: "Title 2", description: "Description 2", dueDate: Date.now, status: .todo),
        Task(title: "Title 3", description: "Description 3", dueDate: Date.now, status: .todo)
    ]
    
    static var previews: some View {
        TaskListView(status: .todo, tasks: $dummyTodoTasks)
    }
}
