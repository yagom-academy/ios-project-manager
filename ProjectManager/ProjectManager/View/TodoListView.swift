//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct TodoListView<T>: View where T: ViewModel {
   @ObservedObject var viewModel: T
    var body: some View {
        List {
            Section {
                ForEach(Todo.dummyToDoList) { todo in
                    TodoRowView(todo: todo)
                }
            } header: {
                HStack {
                    Text("TODO")
                    Text("3")
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
        TodoListView(viewModel: ToDoListViewModel())
    }
}
