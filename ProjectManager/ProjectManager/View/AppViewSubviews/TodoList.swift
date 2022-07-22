//
//  TodoListView.swift
//  ProjectManager
//
//  Created by Red and Taeangel on 2022/07/06.

import SwiftUI

struct TodoListView: View {
  @ObservedObject var viewModel: ListViewModel
  
  init(viewModel: ListViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 0) {
      HeaderView(title: viewModel.status, listCount: viewModel.listCount)
      
      ZStack {
        Color(UIColor.systemGray5)
        List {
          ForEach(viewModel.todoList) { todo in
            ListCellView(todo: todo, viewModel: viewModel)
              .listRowSeparator(.hidden)
          }
          .onDelete { index in
            viewModel.delete(set: index)
          }
        }
        .padding(.horizontal, -24)
        .listStyle(.inset)
        .onAppear {
          UITableView.appearance().backgroundColor = .clear
        }
      }
    }
  }
}

struct ListCellView: View {
  @ObservedObject var viewModel: ListViewModel
  let todo: Todo
  
  init(todo: Todo, viewModel: ListViewModel) {
    self.todo = todo
    self.viewModel = viewModel
  }
  
  var body: some View {
    TodoListCell(todo)
      .onTapGesture(perform: {
        viewModel.cellButtonTapped()
      })
      .onLongPressGesture(perform: {
        viewModel.cellButtonLongPressed()
      })
      .sheet(isPresented: $viewModel.isShowEditView) {
        EmptyView()
//        EditView(todo: todo, viewModel: viewModel.editViewModel) {
//          viewModel.closeButtonTapped()
//        }
        .popover(isPresented: $viewModel.isLongPressing) {
          EmptyView()
          //        TodoListPopOver(isShow: $isLongPressing, todo: todo, updata: updata)
        }
      }
  }
}
