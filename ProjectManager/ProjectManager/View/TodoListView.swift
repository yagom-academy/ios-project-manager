//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct TodoListView: View {
    @EnvironmentObject var todoListViewModel: ToDoListViewModel
    let type: SortType
    var body: some View {
        VStack {
            HStack {
                Text(type.description)
                    .padding(.leading)
                Text(todoListViewModel.todoCount(type: type))
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Circle())
                Spacer()
            }
            .font(.title)
            .foregroundColor(.black)
            List {
                    ForEach(todoListViewModel.fetchList(type: type)) { todo in
                        TodoRowView(todo: todo)
                    }
                    .onDelete { indexSet in todoListViewModel.action(
                        .delete(indexSet: indexSet))
                    }
             }
            .listStyle(.plain)
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(type: .done)
    }
}
