//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct TodoListPopOver: View {
  @Binding var isShow: Bool
  let todo: Todo
  private let updata: (Todo.Status, Todo) -> Void
  
  init(isShow: Binding<Bool>, todo: Todo, updata: @escaping (Todo.Status, Todo) -> Void) {
    self._isShow = isShow
    self.todo = todo
    self.updata = updata
  }
  
  var body: some View {
    VStack {
      switch todo.status {
      case .todo:
        MoveButton(isShow: $isShow, todo: todo, status: .doing, updata: updata)
        MoveButton(isShow: $isShow, todo: todo, status: .done, updata: updata)
      case .doing:
        MoveButton(isShow: $isShow, todo: todo, status: .todo, updata: updata)
        MoveButton(isShow: $isShow, todo: todo, status: .done, updata: updata)
      case .done:
        MoveButton(isShow: $isShow, todo: todo, status: .todo, updata: updata)
        MoveButton(isShow: $isShow, todo: todo, status: .doing, updata: updata)
      }
    }
    .padding()
  }
}

struct MoveButton: View {
  @Binding var isShow: Bool
  let todo: Todo
  let status: Todo.Status
  private let updata: (Todo.Status, Todo) -> Void
  
  init(isShow: Binding<Bool>, todo: Todo, status: Todo.Status, updata: @escaping (Todo.Status, Todo) -> Void) {
    self._isShow = isShow
    self.todo = todo
    self.status = status
    self.updata = updata
  }
  
  var body: some View {
    Button("MOVE to \(status.rawValue)") {
      updata(status, todo)
      isShow = false
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
