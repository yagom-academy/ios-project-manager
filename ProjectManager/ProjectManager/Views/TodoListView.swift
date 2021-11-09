//
//  TodoListView.swift
//  ProjectManager
//
//  Created by YongHoon JJo on 2021/11/02.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todoListVM: TodoListViewModel
    let todoStatus: TodoStatus
    var todoList: [TodoViewModel]
    
    init(todoStatus: TodoStatus, todoList: [TodoViewModel]) {
        self.todoStatus = todoStatus
        self.todoList = todoList.filter { $0.status == todoStatus }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TodoListHeaderView(title: todoStatus.title, count: todoList.count)
            List {
                ForEach(todoList) { todoItem in
                    TodoItemView(todo: todoItem)
                }
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
            
            Spacer()
        }
        .background(Color.init(UIColor(red: 239/256,
                                       green: 239/256,
                                       blue: 239/256,
                                       alpha: 1)))
    }
}

extension TodoListView {
    func delete(at offsets: IndexSet) {
        guard let index = offsets.first else {
            return
        }
        
        todoListVM.deleteTodo(at: todoList[index].id)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoStatus: .todo,
                     todoList: Todo.generateMockTodos().map { TodoViewModel(todo: $0) })
            .previewLayout(.fixed(width: 500, height: 1200))
    }
}
