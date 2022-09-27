//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    
    private var todoListViewModel: TodoListViewModel
    @EnvironmentObject private var dataManager: TodoDataManager
    
    init(status: Status) {
        self.todoListViewModel = TodoListViewModel(status: status)
    }
    
    var body: some View {
        VStack {
            titleHeaderView(status: todoListViewModel.status, taskCount: todoListViewModel.countTodoData(dataManager: dataManager))
            List {
                ForEach(Array(zip(todoListViewModel.fetchTodoData(dataManager: dataManager).indices, todoListViewModel.fetchTodoData(dataManager: dataManager))), id: \.0) { index, task in
                    TodoListRow(todo: task, index: index)
                }
                .onDelete { index in
                    todoListViewModel.removeData(dataManager: dataManager, indexSet: index)
                }
            }
            .listStyle(.plain)
        }
        .background(Color(UIColor.systemGray6))
        Divider()
    }
    
    private func titleHeaderView(status: Status, taskCount: Int) -> some View {
        HStack(spacing: 10) {
            Text(status.text)
                .font(.largeTitle)
            Text("\(taskCount)")
                .font(.title3)
                .frame(width: 28.5, height: 24)
                .padding(.all, 3)
                .colorInvert()
                .background(Color.primary)
                .clipShape(Circle())
            Spacer()
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: -1, trailing: 0))
    }
}
