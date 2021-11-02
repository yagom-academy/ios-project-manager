//
//  TodoList.swift
//  ProjectManager
//
//  Created by 오승기 on 2021/11/01.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var todoList: TodoViewModel
    var todoState: TodoState
    var body: some View {
        List {
            Section(header: ToDoListHeaderView(todoState: todoState)) {
                ForEach(todoList.memo) { data in
                    TodoCellView(memo: data)
                }
            }
        }
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList(todoState: .todo)
    }
}
