//
//  DetailView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct DetailView: View {
  @Binding var todo: Todo
  
  init(todo: Binding<Todo>) {
    self._todo = todo
  }
  
  var body: some View {
    VStack {
      ZStack {
        Rectangle()
          .fill(.white)
          .shadow(color: .gray, radius: 3, x: 0, y: 1)
          .frame(height: 30)
        TextField("title", text: $todo.title)
          .padding(.leading)
      }
      
      DatePicker("", selection: $todo.date)
        .datePickerStyle(.wheel)
        .labelsHidden()
      TextEditor(text: $todo.content)
        .shadow(color: .gray, radius: 3, x: 0, y: 1)
    }
    .padding()
    .navigationTitle("TODO")
    .font(.body)
    .navigationBarTitleDisplayMode(.inline)
  }
}
