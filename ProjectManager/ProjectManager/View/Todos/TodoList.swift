//
//  TodoList.swift
//  ProjectManager
//
//  Created by Yongwoo Marco on 2021/10/28.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject private var todoViewModel: TodoViewModel
    var completionState: Todo.Completion
    
    private var filteredTodos: [Todo] {
        todoViewModel.todos.filter { todo in
            todo.completionState == self.completionState
        }
    }
    
    var body: some View {
        List {
            Section(
                content: {
                    ForEach(filteredTodos, id: \.self) { todo in
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
                            Text(filteredTodos.count.description)
                                .foregroundColor(.white)
                        }
                        .font(.title2)
                    }
                }
            )
        }
        .listStyle(.grouped)
    }
    
    func delete(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let removingTodo = filteredTodos[index]
            guard let firstIndex = todoViewModel.todos.firstIndex(of: removingTodo) else {
                NSLog("해당 투두를 찾을 수 없음")
                return
            }
            todoViewModel.todos.remove(at: firstIndex)
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(completionState: .done)
            .environmentObject(TodoViewModel())
    }
}
