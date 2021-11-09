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
                    ForEach(viewModel.eachStateTodoList(completionState), id: \.self) { todo in
                        TodoRow(todo: todo)
                    }
                    .onDelete(perform: self.delete)
                },
                header: {
                    HStack {
                        Text(completionState.description)
                            .font(.title)
                            .foregroundColor(.black)
                        ZStack {
                            Image(systemName: "circle.fill")
                                .foregroundColor(.black)
                            Text(viewModel.eachStateTodoList(completionState).count.description)
                                .foregroundColor(.white)
                        }
                        .font(.title2)
                    }
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
            viewModel.deleteTodo(removingTodo)
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
