//
//  TodoList.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoStateList: View {
    @EnvironmentObject private var viewModel: TodoViewModel
    var completionState: TodoList.Completion
    
    var body: some View {
        List {
            Section(
                content: {
                    ForEach(viewModel.eachStateTodoList(completionState)) { todo in
                        TodoRow(todo: todo)
                    }
                    .onDelete(perform: self.delete)
                },
                header: {
                    TodoStateHeader(headerTitle: completionState.description,
                                    todoListCount: viewModel.eachStateTodoList(completionState).count.description)
                }
            )
        }
        .listStyle(.grouped)
    }
}

extension TodoStateList {
    private func delete(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let removingTodo = viewModel.eachStateTodoList(completionState)[index]
            viewModel.deleteItem(removingTodo)
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoStateList(completionState: .doing)
            .environmentObject(TodoViewModel())
            .previewLayout(.sizeThatFits)
    }
}
