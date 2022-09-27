//
//  TodoListRow.swift
//  ProjectManager
//
//  Created by Kiwi on 2022/09/12.
//

import SwiftUI

struct TodoListRow: View {
    
    @EnvironmentObject private var dataManager: TodoDataManager
    @ObservedObject private var todoListRowViewModel: TodoListRowViewModel
    
    init(todo: Todo, index: Int) {
        _todoListRowViewModel = ObservedObject(wrappedValue: TodoListRowViewModel(todo: todo, index: index))
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(todoListRowViewModel.todo.title)
                    .font(.title3)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text(todoListRowViewModel.todo.body)
                    .font(.body)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                    .truncationMode(.tail)
                Text(todoListRowViewModel.todo.date.dateString)
                    .font(.callout)
                    .foregroundColor(todoListRowViewModel.todo.date.isOverdue ? .red : .black)
            }
            Spacer()
        }
        .padding(.all, 5)
        .contentShape(Rectangle())
        .onTapGesture {
            todoListRowViewModel.showingSheet.toggle()
        }
        .sheet(isPresented: $todoListRowViewModel.showingSheet, content: {
            TodoContentView(todo: todoListRowViewModel.todo, buttonType: "Edit", index: todoListRowViewModel.index, showingSheet: $todoListRowViewModel.showingSheet)
        })
        .onLongPressGesture(perform: {
            todoListRowViewModel.statusChanging.toggle()
        })
        .popover(isPresented: $todoListRowViewModel.statusChanging) {
            ZStack {
                Color(UIColor.quaternarySystemFill)
                    .scaleEffect(1.5)
                VStack(spacing: 6) {
                    ForEach(Status.allCases, id: \.self) { status in
                        if status != todoListRowViewModel.todo.status {
                            Button {
                                todoListRowViewModel.changeStatus(status: status, dataManager: dataManager)
                            } label: {
                                Text("Move to \(status.text)")
                                    .frame(width: 250, height: 50)
                                    .background(Color(UIColor.systemBackground))
                            }
                        }
                    }
                }
                .padding(.all, 10)
                .font(.title2)
            }
        }
    }
}
