//
//  TodoListRow.swift
//  ProjectManager
//
//  Created by Kiwon Song on 2022/09/12.
//

import SwiftUI

struct TodoListRow: View {
    
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(todo.title)
                .font(.title3)
                .lineLimit(1)
                .truncationMode(.tail)
            Text(todo.body)
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(3)
                .truncationMode(.tail)
            Text(todo.date.dateString)
                .font(.callout)
                .foregroundColor(todo.date.isOverdue ? .red : .black)
        }
    }
}

struct TodoListRow_Previews: PreviewProvider {
    static var previews: some View {
        TodoListRow(todo: Todo(title: "제목", body: "내용", date: Date(), status: .todo))
    }
}
