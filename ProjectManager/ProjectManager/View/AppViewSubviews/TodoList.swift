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
  @State var isLongPressing: Bool = true
  @State var isShowEditView: Bool = false
  let todo: Todo
  @ObservedObject var viewModel: ListViewModel
  
  init(todo: Todo, viewModel: ListViewModel, isLongPressing: Bool = false, isShowEditView: Bool = false) {
    self.todo = todo
    self.viewModel = viewModel
    self.isLongPressing = isLongPressing
    self.isShowEditView = isShowEditView
  }
  
  var body: some View {
    TodoListCell(todo)
      .onTapGesture(perform: {
        isShowEditView.toggle()
      })
      .onLongPressGesture(perform: {
        isLongPressing.toggle()
      })
      .sheet(isPresented: $isShowEditView) {
        
        EditView(todo: todo, viewModel: viewModel.editViewModel) {
          viewModel.closeButtonTapped()
        }
      }
      .popover(isPresented: $isLongPressing) {
        
        TodoListPopOver(isShow: $isLongPressing, todo: todo) { status, todo in
          viewModel.updata(status: status, todo: todo)
        }
      }
  }
}
