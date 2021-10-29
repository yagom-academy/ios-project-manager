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
                    ForEach(filteredTodos) { todo in
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
        let TodoIds = indexSet.map { filteredTodos[$0].id }
        TodoIds.forEach { todoId in
            guard let index = todoViewModel.lookForTodoIndex(by: todoId) else {
                NSLog("ID \(todoId) 에 해당하는 Todo를 찾지 못했습니다.")
                return
            }
            todoViewModel.todos.remove(at: index)
        }
        
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(completionState: .done)
            .environmentObject(TodoViewModel())
    }
}
