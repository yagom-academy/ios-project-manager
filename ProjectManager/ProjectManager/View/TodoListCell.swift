//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListCell: View {
  let todo: Todo
  
  init(_ todo: Todo) {
    self.todo = todo
  }
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.white)
      HStack {
        VStack(alignment: .leading) {
            Text(todo.title)
              .font(.title)
              .lineLimit(1)
              .truncationMode(.tail)
            Text(todo.content)
              .font(.body)
              .foregroundColor(.gray)
              .lineLimit(3)
              .truncationMode(.tail)
            Text(todo.date.toString())
              .font(.body)
              .lineLimit(1)
        }
        .padding()
        Spacer()
      }
    }
  }
}

//struct TodoListCell_Previews: PreviewProvider {
//  static var previews: some View {
//    TodoListCell(Todo(title: "제목", content: "본문내용 입니다.", status: .todo))
//  }
//}
