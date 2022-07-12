//
//  TodoListCell.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.
//

import SwiftUI

struct TodoListCell: View {
  @ObservedObject var todo: Todo
  
  init(_ todo: Todo) {
    self.todo = todo
  }
  var body: some View {
    ZStack {
      Rectangle()
        .fill(.white)
        .shadow(color: .gray, radius: 1, x: 0, y: 1)
      
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
