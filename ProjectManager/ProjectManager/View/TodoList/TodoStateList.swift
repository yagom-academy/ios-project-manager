//
//  TodoStateList.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoStateList: View {
    @EnvironmentObject private var viewModel: TodoViewModel
    var todoState: TodoList.State
    
    var body: some View {
        List {
            Section(
                content: {
                    ForEach(viewModel.filteredList(of: todoState)) { todo in
                        TodoStateRow(todo: todo)
                    }
                    .onDelete(perform: self.delete)
                },
                header: {
                    TodoStateHeader(headerTitle: todoState.description,
                                    todoListCount: viewModel.filteredList(of: todoState).count.description)
                }
            )
        }
        .listStyle(.grouped)
    }
}

extension TodoStateList {
    private func delete(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let removingTodo = viewModel.filteredList(of: todoState)[index]
            viewModel.deleteItem(removingTodo)
        }
    }
}

struct TodoStateList_Previews: PreviewProvider {
    static var previews: some View {
        TodoStateList(todoState: .doing)
            .environmentObject(TodoViewModel())
            .previewLayout(.sizeThatFits)
    }
}
