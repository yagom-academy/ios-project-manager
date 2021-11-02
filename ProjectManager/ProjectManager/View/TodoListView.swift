//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct TodoListView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @State private var isPresented: Bool = false
    let type: SortType
    var body: some View {
        List {
            Section {
                ForEach(viewModel.fetchList(type: type)) { todo in
                    TodoRowView(todo: todo)
                }
            } header: {
                HStack {
                    Text(type.description)
                    Text(viewModel.todoCount(type: type))
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Circle())
                }
                .font(.title)
                .foregroundColor(.black)
            }
         }
        .listStyle(.grouped)
        .padding(1)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: ToDoListViewModel(), type: .done)
    }
}
