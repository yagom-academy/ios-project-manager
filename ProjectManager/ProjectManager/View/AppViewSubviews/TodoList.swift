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
            ListCellView(viewModel: viewModel.makeCellViewModel(todo: todo))
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
        .refreshable {
          viewModel.refrash()
        }
      }
    }
  }
}

struct ListCellView: View {
  @ObservedObject var viewModel: ListCellViewModel
  
  init(viewModel: ListCellViewModel,
       isLongPressing: Bool = false,
       isShowEditView: Bool = false) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    TodoListCell(viewModel.todo)
      .onTapGesture(perform: {
        viewModel.isTapped()
      })
      .onLongPressGesture(perform: {
        viewModel.isLongPressed()
      })
      .sheet(isPresented: $viewModel.isShowEditView) {
        EditView(todo: viewModel.todo, viewModel: viewModel.editViewModel)
      }
      .popover(isPresented: $viewModel.isShowModal) {
        TodoListPopOver(todo: viewModel.todo) { status, todo in
          viewModel.closedModalView(status: status, element: todo)
        }
      }
  }
}
