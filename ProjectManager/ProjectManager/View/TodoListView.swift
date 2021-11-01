//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 박태현 on 2021/11/01.
//

import SwiftUI


struct TodoListView: View {
    var body: some View {
        List {
            Section {
                ForEach(Todo.dummyToDoList) { todo in
                    TodoRowView(todo: todo)
                }
            } header: {
                HStack {
                    Text("TODO")
                    ZStack {
                        Text("3")
                        .foregroundColor(.white)
                        .background(Circle())
                    }
                    Spacer()
                }
                .font(.title)
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
