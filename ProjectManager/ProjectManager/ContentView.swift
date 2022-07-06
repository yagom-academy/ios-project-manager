//
//  ContentView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TodoListCell(Todo(title: "제목", content: "본문내용 입니다.", status: .todo))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
