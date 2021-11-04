//
//  TodoList.swift
//  ProjectManager
//
//  Created by yun on 2021/11/04.
//

import SwiftUI

struct TodoList: View {
    @EnvironmentObject var viewModel: TodoListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todoRowItems) { rowItem in
                    TodoListRow(todoListItem: rowItem)
                }.onDelete(perform: viewModel.remove(at:))
            }
            .navigationTitle("TODO     \(viewModel.todoCount)")
        }
        .navigationViewStyle(.stack)
    }
}

struct TodoList_Previews: PreviewProvider {
    static var previews: some View {
        TodoList()
    }
}

