//
//  TodoListView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import SwiftUI

struct TodoListView: View {
    
    let todoStatus: TodoStatus
    let todoList: [TodoViewModel]
    
    init(todoStatus: TodoStatus, todoList: [TodoViewModel]) {
        self.todoStatus = todoStatus
        self.todoList = todoList.filter { $0.status == todoStatus }
    }
    
    var body: some View {
        VStack {
            TodoListHeaderView(title: todoStatus.title, count: todoList.count)
            
            List(todoList) { todoItem in
                TodoItemView(todo: todoItem)
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoStatus: .todo,
                     todoList: Todo.generateMockTodos().map(TodoViewModel.init))
            .previewLayout(.fixed(width: 400, height: 1200))
    }
}
