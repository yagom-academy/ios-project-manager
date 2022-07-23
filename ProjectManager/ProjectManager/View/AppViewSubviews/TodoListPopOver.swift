//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct TodoListPopOver: View {
  let todo: Todo
  private let updata: (Status, Todo) -> Void
  
  init(todo: Todo, updata: @escaping (Status, Todo) -> Void) {
    self.todo = todo
    self.updata = updata
  }
  
  var body: some View {
    VStack {
      switch todo.status {
      case .todo:
        MoveButton(todo: todo, status: .doing, updata: updata)
        MoveButton(todo: todo, status: .done, updata: updata)
      case .doing:
        MoveButton(todo: todo, status: .todo, updata: updata)
        MoveButton(todo: todo, status: .done, updata: updata)
      case .done:
        MoveButton(todo: todo, status: .todo, updata: updata)
        MoveButton(todo: todo, status: .doing, updata: updata)
      }
    }
    .padding()
  }
}

struct MoveButton: View {
  let todo: Todo
  let status: Status
  private let updata: (Status, Todo) -> Void
  
  init(todo: Todo, status: Status, updata: @escaping (Status, Todo) -> Void) {
    self.todo = todo
    self.status = status
    self.updata = updata
  }
  
  var body: some View {
    Button("MOVE to \(status.rawValue)") {
      updata(status, todo)
    }
    .buttonStyle(GrayBasicButtonStyle())
  }
}

struct GrayBasicButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .font(.body)
      .background(Color(UIColor.systemGray2))
      .foregroundColor(.white)
      .clipShape(RoundedRectangle(cornerRadius: 4))
  }
}
