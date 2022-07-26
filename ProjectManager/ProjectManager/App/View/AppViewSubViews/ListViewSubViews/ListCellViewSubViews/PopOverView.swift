//
//  TodoListPopOver.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/12.
//

import SwiftUI

struct PopOverView: View {
  @ObservedObject var viewModel: PopoverViewModel
  
  init(viewModel: PopoverViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack {
      switch viewModel.todo.status {
      case .todo:
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .doing)
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .done)
      case .doing:
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .todo)
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .done)
      case .done:
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .todo)
        MoveButton(viewModel: viewModel, todo: viewModel.todo, status: .doing)
      }
    }
    .padding()
  }
}

struct MoveButton: View {
  @ObservedObject var viewModel: PopoverViewModel
  let todo: Todo
  let status: Status
  
  init(viewModel: PopoverViewModel, todo: Todo, status: Status) {
    self.todo = todo
    self.viewModel = viewModel
    self.status = status
  }
  
  var body: some View {
    Button("MOVE to \(status.rawValue)") {
      viewModel.updata(status, todo)
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
