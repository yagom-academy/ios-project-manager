//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListView: View {
    
    let todoTasks: [Todo]
    
    var body: some View {
        List {
            ForEach(todoTasks) { task in
                TodoListRow(todo: task)
            }
        }
        .listStyle(.grouped)
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(todoTasks: [Todo(title: "1번 할일", body: "1줄\n2줄\n3줄", date: Date(timeIntervalSinceNow: -86400 * 2), status: .todo),
                                 Todo(title: "2번 할일", body: "1줄\n2줄", date: Date(timeIntervalSinceNow: -86400), status: .todo),
                                 Todo(title: "3번 할일", body: "1줄", date: Date(timeIntervalSinceNow: 86400), status: .todo),
                                 Todo(title: "4번 할일", body: "1줄\n2줄\n3줄\n4줄", date: Date(timeIntervalSinceNow: 86400 * 2), status: .todo)])
        .previewInterfaceOrientation(.landscapeRight)
    }
}
